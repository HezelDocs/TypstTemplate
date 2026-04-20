/*
 * --------------------------------------------------------------------------------
 * File: /home/hezeltm/Projects/typst_template/report/section/honor.typ
 * Project: /home/hezeltm/Projects/typst_template/report/section
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

#import "../data/metadata.typ" : authors

// ---------- Declaration of honor

Je, soussigné, #authors.first().firstname #authors.first().lastname, déclare sur l’honneur que le travail rendu est le fruit d’un travail personnel. Je certifie ne pas avoir eu recours au plagiat ou à toutes autre forme de fraude. Toutes les sources d’information utilisées et les citations d’auteur ont été clairement mentionnées.

#authors.first().locality, le #datetime.today().display("[day].[month].[year]").

TODO ajouter la signature
