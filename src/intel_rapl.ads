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

package Intel_RAPL is

    -- Function to return the current energy value of the RAPL type
    function Get_Intel_RAPL_Energy_By_Package (Package_Type : Unbounded_String) return String;

    -- Calculate total energy consumption from Linux powercap sysfs
    function Get_Intel_RAPL_Energy return String;

    -- Check if package is supported (psys, package-0, or dram)
    -- That is: content of file /sys/devices/virtual/powercap/intel-rapl/intel-rapl:1/name is "psys"
    -- That is: content of file /sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/name is "package-0"
    -- That is: content of file /sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:2/name is "package-0"
    -- So far, only package 0 is supported (and dram in package 0)
    function Check_Supported_Packages (Package_Name : in String) return Boolean;

end Intel_RAPL;
