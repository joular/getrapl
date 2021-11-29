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

with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.OS_Lib; use GNAT.OS_Lib;

with Intel_RAPL; use Intel_RAPL;

procedure Getrapl is
    Package_Type : Unbounded_String;
begin
   -- Loop over command line options
    loop
        case Getopt ("p:") is
        when 'p' => -- For package name
            Package_Type := To_Unbounded_String (Parameter);
        when others =>
            exit;
        end case;
    end loop;

    if (Package_Type = "") then
        Put_Line ("Please specify an Intel RAPL package name to the -p parameter: psys, pkg or dram");
        OS_Exit (0);
    else
        Put_Line (Get_Intel_RAPL_Energy (Package_Type));
    end if;
exception
    when others =>
        Put_Line ("Unrecognized parameter");
        OS_Exit (0);
end Getrapl;
