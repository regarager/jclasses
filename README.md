# jclasses
## A simple plugin to create classes in Java

### Installation

#### Lazy

```lua
{ "regarager/jclasses", dependencies = { "MunifTanjim/nui.nvim" } }`
```
#### Packer

```lua
use {
    "regarager/jclasses", 
    requires = { "MunifTanjim/nui.nvim" }
}
```

### Usage
#### `:JCTest`

Outputs a test message saying `JClasses: OK!`

#### `:JCNew`

Opens a prompt that asks for a class name. The text after the last period (or the entire input if no periods exist) is used as the class name, and all previous text is used as the package name. Note that to be able to automatically detect the package of the current project, you need to have the current editor open to a class in the package. Otherwise, the file is created in Neovim's current working directory.
