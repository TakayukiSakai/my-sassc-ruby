
Gem::Specification.new do |spec|
  spec.name          = "mysassc"
  spec.version       = "0.0.1"
  spec.authors       = ["Takayuki Sakai"]
  spec.email         = ["kaky0922@gmail.com"]
  spec.summary       = "Use libsass with Ruby!"
  spec.description   = "Use libsass with Ruby!"
  spec.homepage      = "https://github.com/TakayukiSakai/my-sassc-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.has_rdoc      = false

  spec.extensions    = ["Rakefile"]

  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ""
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end
end