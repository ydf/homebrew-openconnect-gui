class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  head do
    url "https://gitlab.com/openconnect/openconnect-gui.git", :branch => "develop", :shallow => true
  end

  option "with-ini-settings", "Store the settings in INI files"

  depends_on :macos => :el_capitan

  depends_on :xcode => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "openconnect"

  def install
    ENV.deparallelize

    args = std_cmake_args # .split
    args << "-D PROJ_INI_SETTINGS=on" if build.with? "ini-settings"

    mkdir "build" do
      system "cmake", *args, "../"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
