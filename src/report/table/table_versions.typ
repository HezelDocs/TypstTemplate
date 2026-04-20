/*
 * --------------------------------------------------------------------------------
 * File: /home/hezeltm/Projects/typst_template/report/table/table_versions.typ
 * Project: /home/hezeltm/Projects/typst_template/report/table
 * Created Date: Monday, November 17th 2025, 6:53:51 pm
 * Author: Dimitri Julmy, dev@dimitri-julmy.com
 * --------------------------------------------------------------------------------
 * Last Modified: Fri Dec 19 2025
 * Modified By: Dimitri Julmy
 * --------------------------------------------------------------------------------
 * Copyright (c) 2025 Dimitri Julmy
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * --------------------------------------------------------------------------------
 */


// ---------- Imports

#import "../data/metadata.typ": versions
#import "../data/styling.typ": colors

// ---------- Table of Versions

// Apply styling to the header
#show table.cell.where(y: 0):set text(weight: "medium", size: 13pt, fill: white)

// Apply styling to the frame
#let frame(stroke) = (x, y) => (
  left: if x == 1 {1pt},
  right: if x == 1 {1pt},
  top: if y == 0 or y == 1 {2pt},
  bottom: if y == 0 {2pt} else if y == versions.len() {0pt} else {1pt},
)

// Display versions data
#table(
  columns: (15%, 15%, 70%),
  align: (x,y) => if x == 0 {center + horizon} else if x == 1 {horizon + center} else if x == 2 {horizon},
  inset: 8pt,
  fill: (_, y) => if y == 0 {colors.c3},
  stroke: frame(colors.c1),
  table.header[Version][Date][Modification],
  ..for (version, date, changes) in versions {
    (version, date.display(), changes)
  }
)
