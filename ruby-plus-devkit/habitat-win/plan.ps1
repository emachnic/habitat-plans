$pkg_name="ruby-plus-devkit"
$pkg_origin="stuartpreston"
$pkg_version="2.6.3"
$pkg_revision="1"
$pkg_maintainer="Stuart Preston <stuart@chef.io>"
$pkg_license=@("Apache-2.0")
$pkg_source="https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-${pkg_version}-${pkg_revision}/rubyinstaller-devkit-${pkg_version}-${pkg_revision}-x64.exe"
$pkg_shasum="d30a9d765cc10c744bc5b032d407c763fcbee0c86ee4d6c83dc669318f13e1bb"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
   Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/SP- /NORESTART /VERYSILENT /SUPPRESSMSGBOXES /NOPATH /DIR=$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Build {
   # Launch msys2 once in order to initialize the environment
   Invoke-Expression -Command "cmd /c $HAB_CACHE_SRC_PATH/$pkg_dirname/msys64\msys2_shell.cmd exit /b 0" -Verbose
}

function Invoke-Install {
   # Copy files to the packaging location
   Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force

   # Remove original installer from system state
   Start-Process "$HAB_CACHE_SRC_PATH/$pkg_dirname/unins000.exe" -Wait -ArgumentList "/SILENT /NORESTART"
}
