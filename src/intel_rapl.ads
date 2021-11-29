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

package Intel_RAPL is

    -- Function to return the current energy value of the RAPL type
    function Get_Intel_RAPL_Energy (Package_Type : Unbounded_String) return String;

end Intel_RAPL;
