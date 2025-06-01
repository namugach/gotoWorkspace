# Changelog

All notable changes to this project will be documented in this file.

## [0.3.0] - 2024-06-02

### 🚀 Major Improvements
- **Multi-shell support**: Automatic bash/zsh detection and configuration
- **Stable installation**: Uses `~/.gotoworkspace` directory instead of project directory
- **Complete removal**: Clean uninstallation removes all traces
- **Update functionality**: Preserves user data while updating program files

### ✨ Added
- Automatic shell detection using `$ZSH_VERSION` and `$BASH_VERSION`
- Installation wizard with options (Install/Remove/Update)
- Backup creation for configuration files
- Cross-shell compatibility (bash/zsh/profile)

### 🔧 Fixed
- **Path corruption issue**: No longer depends on project directory location
- **Shell compatibility**: Improved ps command compatibility across systems
- **Installation errors**: Better error handling and validation

### 🔄 Changed
- Installation location: `project_dir/` → `~/.gotoworkspace/`
- Configuration: Single shell detection → Multi-shell support
- User experience: Manual setup → Automated installation

### 🗑️ Removed
- Complex manual installation warnings
- Directory movement restrictions
- Shell-specific installation limitations

---

## [0.2.1] - Previous Version

### Features
- Basic directory navigation utility
- List management (add/edit/delete)
- Select default directory
- Manual installation process

### Known Issues (Fixed in 0.3.0)
- Path corruption when moving project directory
- Shell detection reliability issues
- Manual installation complexity 