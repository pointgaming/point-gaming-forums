def import_model(rails_env, name)
  system "RAILS_ENV=#{rails_env} rake environment tire:import:model CLASS='#{name}'"
end

desc "Index data with elasticsearch"
task :index_data do
  rails_env = ENV['RAILS_ENV'] || "development"

  import_model(rails_env, 'Forem::Post')
end
