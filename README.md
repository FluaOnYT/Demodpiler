# Demodpiler

A script that extracts contents of ModuleScripts all in a string format

## Q&A

### How does it work?

It extracts in 3 steps:

1. "Require" (I.e., import) a ModuleScript
2. Iterate through the contents of the ModuleScript
3. Parse every keys' value into a string and combines them into a pseduocode of the ModuleScript

### What is the current % of type support?

32.5% (Including unsupported ones)
48.1% (Excluding unsupported ones that are non-extractable)

### What are the unsupported types that demodpiler can't extract?

These types include ones unextractable by any means (no properties that can be reversed to arguments for a constructor for such types), types that have a blank constructor, types that do not have a constructor and types that are not used in game (i.e., studio only types)

Region3
RBXScriptSignal
RBXScriptConnection
RaycastResult
RaycastParams [-]
Random
OverlapParams [-]
NumberSequence
Faces
Enums
EnumItem
Enum
DockWidgetPluginGuiInfo
Content
CatalogSearchParams [-]
Axes

Types that have [-] refers to ones extractable through a different method (guess how)
