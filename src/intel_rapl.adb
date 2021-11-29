--
--  Copyright (c) 2021, Adel Noureddine, Université de Pau et des Pays de l'Adour.
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

    function Get_Intel_RAPL_Energy (Package_Type : Unbounded_String) return String is
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

end Intel_RAPL;
