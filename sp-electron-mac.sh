
GAME_NAME="Finding Home"
# This is assuming you have a folder called 'builds' with a folder called 'web' inside it
# Create your build from SuperPowers, pointing the output directory to 'web'
# Run this script from inside the builds folder

# rename the folder where the builds go
DESKTOP_BUILDS_DIR="desktop_builds"

# names for build folders
WIN_32_BUILD="electron-win-32"
WIN_64_BUILD="electron-win-64"
MAC_BUILD="electron-mac"
LINUX_BUILD="electron-linux"

mkdir electron_releases

cp sample_main.js web/main.js
cp sample_package.json web/package.json

# download the required electron builds
echo "downloading files required to create Mac Build"
curl "https://github.com/electron/electron/releases/download/v1.4.12/electron-v1.4.12-darwin-x64.zip" -o "electron_releases/${MAC_BUILD}.zip"

echo "downloading files required to create Windows (32bit) Build"
curl "https://github.com/electron/electron/releases/download/v1.4.12/electron-v1.4.12-win32-ia32.zip" -o "electron_releases/${WIN_32_BUILD}.zip"

echo "downloading files required to create Windows (64bit) Build"
curl "https://github.com/electron/electron/releases/download/v1.4.12/electron-v1.4.12-win32-x64.zip" -o "electron_releases/${WIN_64_BUILD}.zip"

echo "downloading files required to create Linux (64bit) Build"
curl "https://github.com/electron/electron/releases/download/v1.4.12/electron-v1.4.12-linux-x64.zip" -o "electron_releases/${LINUX_BUILD}.zip"

# destroy previous builds
rm -rf "${DESKTOP_BUILDS_DIR}" && mkdir "${DESKTOP_BUILDS_DIR}"

# #  make win 32 build
  unzip electron_releases/"${WIN_32_BUILD}".zip  -d "${DESKTOP_BUILDS_DIR}"/
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/locales
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/pdf.dll
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/version
  rsync -avP web/ "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/resources/app/
  mv "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/electron.exe "${DESKTOP_BUILDS_DIR}"/"${WIN_32_BUILD}"/"${GAME_NAME}".exe
  echo "Windows 32 bit build done"


# # make win 64 build
  unzip electron_releases/"${WIN_64_BUILD}".zip -d "${DESKTOP_BUILDS_DIR}"/
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/locales
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/pdf.dll
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/version
  rsync -avP web/ "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/resources/app/
  mv "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/electron.exe "${DESKTOP_BUILDS_DIR}"/"${WIN_64_BUILD}"/"${GAME_NAME}".exe
  echo "Windows 64 bit build done"


# # make lin 64 build
  unzip electron_releases/"${LINUX_BUILD}".zip  -d "${DESKTOP_BUILDS_DIR}"/
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${LINUX_BUILD}"/locales
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${LINUX_BUILD}"/version
  rsync -avP web/ "${DESKTOP_BUILDS_DIR}"/"${LINUX_BUILD}"/resources/app/
  mv "${DESKTOP_BUILDS_DIR}"/"${LINUX_BUILD}"/electron "${DESKTOP_BUILDS_DIR}"/"${LINUX_BUILD}"/"${GAME_NAME}"
  echo "Linux build done"


# # make mac 64 build
  unzip electron_releases/"${MAC_BUILD}".zip  -d "${DESKTOP_BUILDS_DIR}"/
  rm -rf "${DESKTOP_BUILDS_DIR}"/"${MAC_BUILD}"/Electron.app/version
  rsync -aP web/ "${DESKTOP_BUILDS_DIR}"/"${MAC_BUILD}"/Electron.app/Contents/Resources/app/
  mv "${DESKTOP_BUILDS_DIR}"/"${MAC_BUILD}"/Electron.app "${DESKTOP_BUILDS_DIR}"/"${MAC_BUILD}"/"${GAME_NAME}".app
  echo "Mac OS X build done"
