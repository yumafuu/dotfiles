Pry.config.editor = "nvim"
Pry.config.color = true
if defined?(PryByebug)
  Pry.commands.alias_command 'st', 'step'
  Pry.commands.alias_command 'ne', 'next'
  Pry.commands.alias_command 'fi', 'finish'
  Pry.commands.alias_command 'co', 'continue'
end

Pry.config.prompt = Pry::Prompt.new(
  "custom",
  "my_custom",
  [ proc { |obj, nest_level, _|
      version = ''
      version << "#{Rails.version} " if defined? Rails
      version << "\001\e[0;31m\002"
      version << "#{RUBY_VERSION}"
      version << "\001\e[0m\002"

      "#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
    }
  ]
)
