class Jena < Formula
  desc "Framework for building semantic web and linked data apps"
  homepage "https://jena.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=jena/binaries/apache-jena-4.3.2.tar.gz"
  mirror "https://archive.apache.org/dist/jena/binaries/apache-jena-4.3.2.tar.gz"
  sha256 "f863717fbf519261d45c8f7d7b70592326e88848fc4e255f56d9604000e4bbe6"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c60bec09fe651ecd7724210baab86dc9adcf6484d2da982fd51f415286773a20"
  end

  depends_on "openjdk"

  def install
    env = {
      JAVA_HOME: Formula["openjdk"].opt_prefix,
      JENA_HOME: libexec,
    }

    rm_rf "bat" # Remove Windows scripts

    libexec.install Dir["*"]
    Pathname.glob("#{libexec}/bin/*") do |file|
      next if file.directory?

      basename = file.basename
      next if basename.to_s == "service"

      (bin/basename).write_env_script file, env
    end
  end

  test do
    system "#{bin}/sparql", "--version"
  end
end
