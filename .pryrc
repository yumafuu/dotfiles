Pry.config.color = true
if defined?(PryByebug)
  Pry.commands.alias_command 'st', 'step'
  Pry.commands.alias_command 'ne', 'next'
  Pry.commands.alias_command 'fi', 'finish'
  Pry.commands.alias_command 'co', 'continue'
end

Pry.config.prompt = proc do |obj, nest_level, _pry_|
version = ''
version << "#{Rails.version} " if defined? Rails
version << "\001\e[0;31m\002"
version << "#{RUBY_VERSION}"
version << "\001\e[0m\002"

"#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end
