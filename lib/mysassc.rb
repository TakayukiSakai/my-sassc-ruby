
class Mysassc
  def self.hi
    puts "Hello world!"
  end

  def self.convert(input)
    data_context = Native.make_data_context(input)
    context = Native.data_context_get_context(data_context)
    css = Native.context_get_output_string(context)
    css.force_encoding(@template.encoding)
  end
end


module Native
  spec = Gem::Specification.find_by_name("mysassc")
  gem_root = spec.gem_dir
  ffi_lib "#{gem_root}/ext/libsass/lib/libsass.so"

  typedef :pointer, :sass_context_ptr
  typedef :pointer, :sass_data_context_ptr

  attach_function :malloc, [:size_t], :pointer
  attach_function :_make_data_context, :sass_make_data_context, [:pointer], :sass_data_context_ptr
  attach_function :data_context_get_context, [:sass_data_context_ptr], :sass_context_ptr
  attach_function :context_get_output_string, [:sass_context_ptr], :string

  def self.make_data_context(data)
    _make_data_context(Native.native_string(data))
  end

  def self.native_string(string)
    string = string.to_s
    string << "\0"
    data = Native.malloc(string.bytesize)
    data.write_string(string)
    data
  end
end
