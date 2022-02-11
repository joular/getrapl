--
--  Copyright (c) 2021-2022, Adel Noureddine, Université de Pau et des Pays de l'Adour.
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the
--  GNU General Public License v3.0 only (GPL-3.0-only)
--  which accompanies this distribution, and is available at:
--  https://www.gnu.org/licenses/gpl-3.0.en.html
--
--  Author : Adel Noureddine
--

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.OS_Lib; use GNAT.OS_Lib;

package body Intel_RAPL is

    function Get_Intel_RAPL_Energy_By_Package (Package_Type : Unbounded_String) return String is
        F_Name : File_Type; -- File handle
        Folder_Name : constant String := "/sys/class/powercap/intel-rapl/"; -- Folder prefix for file to read
    begin
        if (Package_Type = "psys") then
            -- Read energy_uj which is in micro joules
            Open (F_Name, In_File, Folder_Name & "intel-rapl:1/energy_uj");
            return Get_Line (F_Name);
        elsif (Package_Type = "pkg") then
            -- Read energy_uj which is in micro joules
            Open (F_Name, In_File, Folder_Name & "intel-rapl:0/energy_uj");
            return Get_Line (F_Name);
        elsif (Package_Type = "dram") then
            -- Read energy_uj which is in micro joules
            Open (F_Name, In_File, Folder_Name & "intel-rapl:0/intel-rapl:0:2/energy_uj");
            return Get_Line (F_Name);
        else
            Put_Line ("Undefined or unavailable Intel RAPL package");
            OS_Exit (0);
        end if;
    exception
        when others =>
            Put_Line ("Error reading file. Did you run with root privileges?");
            OS_Exit (0);
    end;

    function Get_Intel_RAPL_Energy return String is
        type RAPL_Integer is range 0 .. 999999999999999999;
        F_Name : File_Type; -- File handle
        Folder_Name : constant String := "/sys/class/powercap/intel-rapl/"; -- Folder prefix for file to read
        Total_RAPL_Value : Unbounded_String;
        Total_RAPL : RAPL_Integer := 0; -- Total energy of RAPL sensor (psys, or pkg + dram, or pkg)
    begin
        if Check_Supported_Packages ("psys") then
            -- Read energy_uj which is in micro joules
            Open (F_Name, In_File, Folder_Name & "intel-rapl:1/energy_uj");
            Total_RAPL := RAPL_Integer'Value (Get_Line (F_Name));
            Close (F_Name);
        elsif Check_Supported_Packages ("pkg") then
            -- Read energy_uj which is in micro joules
            Open (F_Name, In_File, Folder_Name & "intel-rapl:0/energy_uj");
            Total_RAPL_Value := To_Unbounded_String (Get_Line (F_Name));
--            Total_RAPL := Integer'Value (To_String (Total_RAPL_Value));
            Total_RAPL := RAPL_Integer'Value (To_String (Total_RAPL_Value));
            Close (F_Name);

            -- For pkg, also check dram because total energy = pkg + dram
            if Check_Supported_Packages ("dram") then
                Put_Line ("dram");
                -- Read energy_uj which is in micro joules
                Open (F_Name, In_File, Folder_Name & "intel-rapl:0/intel-rapl:0:2/energy_uj");
                Total_RAPL_Value := To_Unbounded_String (Get_Line (F_Name));
                Total_RAPL := Total_RAPL + RAPL_Integer'Value (To_String (Total_RAPL_Value));
            end if;
        else
            return RAPL_Integer'Image (Total_RAPL);
        end if;
        return RAPL_Integer'Image (Total_RAPL);
    end;

    function Check_Supported_Packages (Package_Name : in String) return Boolean is
        F_Name : File_Type; -- File handle
        Folder_Name : constant String := "/sys/class/powercap/intel-rapl/"; -- Folder prefix for file to read
        Supported_Result : Boolean := False;
    begin
        if (Package_Name = "psys") then
            Open (F_Name, In_File, Folder_Name & "intel-rapl:1/name");
        elsif (Package_Name = "pkg") then
            Open (F_Name, In_File, Folder_Name & "intel-rapl:0/name");
        elsif (Package_Name = "dram") then
            Open (F_Name, In_File, Folder_Name & "intel-rapl:0/intel-rapl:0:2/name");
        else
            return False;
        end if;

        declare
            Name_Intel : String := Get_Line (F_Name);
        begin
            if (Name_Intel = "psys") then
                Supported_Result := True;
            elsif (Name_Intel = "package-0") then
                Supported_Result := True;
            elsif (Name_Intel = "dram") then
                Supported_Result := True;
            else
                Supported_Result := False;
            end if;
        end;
        Close (F_Name);
        return Supported_Result;
    exception
        when others =>
            return False;
    end;

end Intel_RAPL;
