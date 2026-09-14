# HDI_ORDA_Statistics

A 4D v17 **HDI** (How Do I) binary database converted to a 4D project using 4D 21. The codebase was then modernised for 4D 21 R-series conventions with the help of **GitHub Copilot**.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v17. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool.

- **Blog post:** https://blog.4d.com/compute-statistics-on-entity-selection/
- **Original download:** https://download.4d.com/Demos/4D_v17/HDI_ORDA_Statistics.zip

## Features

- **ORDA entity selection statistics** -- `Employee` records are loaded into an entity selection and the listbox footers are bound directly to ORDA statistics methods as `dataSource` expressions, with no intermediate variables:
  - `.max("salary")`, `.min("salary")`, `.sum("salary")`, `.average("salary")`, `.count("extra.hobby")`
- **Related-entity aggregation** -- `.distinct("extra.hobby")` collects the set of unique hobby values across an entity selection's related records.
- **Two-table demo dataset** -- `Employee` data (and its related `INFO` reference data) is seeded from bundled `en`/`ja` JSON resources on first run via `ds.Employee.fromCollection(...)`, so the example runs standalone without an existing dataset.
- **Localized walkthrough content** -- the tab titles, descriptions, and direction text on the main form are all read from `INFO-en.json` / `INFO-ja.json` at runtime based on `Get database localization`, independent of the UI's own XLIFF strings.

## Points of Interest

- **XLIFF localisation** -- all menu, form, and method-level user-facing strings are resolved via `:xliff:ID` (JSON) and `Localized string(...)` (method code), backed by `Resources/en.lproj` and `Resources/ja.lproj` translation files, instead of hardcoded literals.
- **Modern startup pattern** -- `00_Start` uses `CALL WORKER` + non-blocking `DIALOG(...; *)` and a window-reuse-by-title check, replacing the older `New process` / blocking-dialog pattern; `INVOKE ACTION(ak return to design mode)` replaces `QUIT 4D` for a graceful return to the IDE.
- **Dark mode support** -- form colours use 4D's `"automatic"` / `"automaticAlternate"` values, with the few intentionally branded colours (link text, panel background) driven by CSS classes and `prefers-color-scheme` media queries in `styleSheets.css`.
- **macOS Tahoe Liquid Glass adaptation** -- button heights are set via `form-theme: liquid-glass` / `mac-classic` media queries in `styleSheets_mac.css` rather than hardcoded in the form JSON, so buttons render with the correct rounded/square style per platform theme.
- **Listbox display defaults** -- every listbox column disables ellipsis truncation (`truncateMode: "none"`) and every listbox uses legacy (last-column-grows) resizing (`resizingMode: "legacy"`), so column widths stay predictable.
- **Run Method dialog hygiene** -- form-dependent subroutines and object methods (e.g. `BtnDemo`, `ViewHobbiesButton`, `vRecNum`) are marked `invisible` so they don't appear as spurious standalone entries in Run > Method....
- **Modern variable declarations** -- legacy `C_LONGINT`/`C_TEXT`/`C_OBJECT` directives have been replaced with `var` (locals) and `#DECLARE` (parameters/return values), per current 4D language conventions.

## References

- [Entity selection statistics functions](https://developer.4d.com/docs/API/EntitySelectionClass#average) (`average`, `count`, `distinct`, `max`, `min`, `sum`)
- [ORDA -- Object Relational Data Access](https://developer.4d.com/docs/ORDA/orda)
- [XLIFF localisation in 4D](https://developer.4d.com/docs/Notes/xliff)
- [Dark mode / automatic colours](https://developer.4d.com/docs/settings/interface#color-scheme)
- [CSS in 4D forms](https://developer.4d.com/docs/FormEditor/stylesheets)
- [Menus -- standard actions](https://developer.4d.com/docs/Menus/properties)
- [Project method properties (`invisible`, etc.)](https://developer.4d.com/docs/Project/project-method-properties)
- [List Box Column properties (`truncateMode`, `resizingMode`)](https://developer.4d.com/docs/FormObjects/listbox-column)

## Screenshots
