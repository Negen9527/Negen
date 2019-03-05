# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "Negen9527"
  spec.version       = "0.1.3"
  spec.authors       = ["Negen"]
  spec.email         = ["1096041251@qq.com"]

  spec.summary       = %q{Customizable dark theme for Jekyll.}
  spec.description   = "Customizable dark theme for Jekyll. Supports tags, comments, analytics, share buttons."
  spec.homepage      = "https://github.com/Negen9527/Negen9527"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(includes|layouts|sass|posts|tag)/|(LICENSE|README)((\.(txt|md|markdown|xml)|$)))}i)
  end

  spec.add_development_dependency "jekyll", "~> 3.5"
  spec.add_development_dependency "bundler", "~> 1.12"
end
