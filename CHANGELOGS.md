# RBLXUtils Changelog

## 09/11/2023:
- Added error handling with attempts for `MarketplaceService/GamePassService.lua`
- Added CountryLocateService can be found in `LocalizationService/CountryLocateService.lua`

## 10/11/2023:
- Added a new file with the types + better documentation for them: `LocalizationService/Types.lua`
- Added better documentation for `LocalizationService/CountryLocateService.lua`
- Added one new type "CountryData": `LocalizationService/Types.lua`
- Set `LocalizationService/CountryLocateService.lua` to `--!strict` mode + fixed a type checking error.
- Changed "CountrySample" function to "RandomCountry" in `LocalizationService/CountryLocateService.lua`

## 11/11/2023:
- Added `--!strict` mode for `MarketplaceService/GamePassService.lua`
- Added more type checking for `MarketplaceService/GamePassService.lua`
- Better documentation for `MarketplaceService/GamePassService.lua`

## 12/11/2023:
- `Http/load.lua` renamed to "LoadJsonData.lua"
- Added `--!strict` mode + type checking for `LoadJsonData.lua`
- Better README.md file.
- Added a doc directory
- Clearer repo, organized it added a modules folder as well.

**RagdollEngine/RagdollService.lua : Version: 1.1**

- Added type checking + `--!strict` mode for `RagdollEngine/RagdollService.lua`
- Added documentation for it + Version
- Added so when unragdolling a character you set the WalkSpeed/JumpPower (optional)

**RagdollEngine/RagdollService.lua : Version: 1.2**
- Fixed 2 type checking errors in `RagdollEngine/RagdollService.lua`

**LocalizationService/CountryLocateService/CountryLocateService.lua : Version: 1.6**
- Added a new function ".new()" a clearer way of creating your countries that can be added to the countries table through the AddCountryToList() method.
  
- Added `examples` folder which i will work on it soon.

## 16/11/2023:

- Fixed a type checking bug in MarketplaceService/GamePassService.lua
> TODOS: You probably seen some todos in my script, im gonna work on them soon.
