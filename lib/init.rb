# Copyright 2009 Alexander E. Fischer <aef@raxys.net>
#
# This file is part of Init.
#
# Init is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Namespace for projects of Alexander E. Fischer <aef@raxys.net>
#
# If you want to be able to simply type Example instead of Aef::Example to
# address classes in this namespace simply write the following before using the
# classes:
#
#  include Aef
module Aef
  
end

libdir = File.dirname(__FILE__)
require File.join(libdir, 'init/init')
