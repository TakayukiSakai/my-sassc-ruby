
task default: :build

desc "Build libsass"
task :build do
  cd "ext/libsass" do
    sh 'make lib/libsass.so LDFLAGS="-Wall -O2"'
  end
end
