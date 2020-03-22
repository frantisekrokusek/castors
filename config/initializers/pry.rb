# frozen_string_literal: true

old_prompt = Pry.config.prompt
env_str = "#{Rails.application.class.parent}/#{Rails.env}".downcase

if Rails.env.production?
  # Can't do this because it messes with bash history for some reason
  # env = Pry::Helpers::Text.red(env_str)
  env = "\001\e[0;31m\002#{env_str}\001\e[0m\002"
else
  # Can't do this because it messes with bash history for some reason
  # env = Pry::Helpers::Text.green(env_str)
  env = "\001\e[0;32m\002#{env_str}\001\e[0m\002"
end

Pry.config.prompt = [
  proc {|*a| "#{env}: #{Pry::Helpers::Text.blue(Apartment::Tenant.current)} -> #{old_prompt.first.call(*a)}"},
  proc {|*a| "#{env}: #{Pry::Helpers::Text.blue(Apartment::Tenant.current)} -> #{old_prompt.second.call(*a)}"},
]
# select default demo tenant when entering console
class WelcomeDemoClass
  def self.select_demo
    Apartment::Tenant.switch! 'demo'
    # announce current tenant
    puts "You are now Tenant 'demo'"
  end
end

if Rails.env.development?
  Pry.config.exec_string = WelcomeDemoClass.select_demo
end
