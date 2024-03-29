# <a href="https://www.noureddine.org/research/joular/"><img src="https://raw.githubusercontent.com/joular/.github/main/profile/joular.png" alt="Joular Project" width="64" /></a> GetRAPL :zap:

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue)](https://www.gnu.org/licenses/gpl-3.0)
[![Ada](https://img.shields.io/badge/Made%20with-Ada-blue)](https://www.adaic.org)

GetRAPL is a command line tool to easily read the Intel RAPL packages energy values.

Currently we support reading, when supported by the processor, the following packages: psys, pkg and dram.

## :bulb: Usage

To use it, just run the tool with the packag name given to the ```-p``` parameter:

```
getrapl -p psys
getrapl -p pkg
getrapl -p dram
```

You can also run it without parameters and GetRAPL will automatically detect which Intel RAPL package is supported and provide the most complete value : either psys alone, either pkg alone, either pkg + dram together if both are present and psys is not.

```
getrapl
```

On 5.10+ Linux kernels, RAPL packages can't be read without elevated privileges.
So either run the tool with ```sudo getrapl``` or give reading permissions to the ```energy_uj``` files for all RAPL packages.

## :newspaper: License

PowerJoular is licensed under the GNU GPL 3 license only (GPL-3.0-only).

Copyright (c) 2021, Adel Noureddine, Université de Pau et des Pays de l'Adour.
All rights reserved. This program and the accompanying materials are made available under the terms of the GNU General Public License v3.0 only (GPL-3.0-only) which accompanies this distribution, and is available at: https://www.gnu.org/licenses/gpl-3.0.en.html

Author : Adel Noureddine
