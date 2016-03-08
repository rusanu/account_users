module AccountUsers
  class Engine < ::Rails::Engine

    initializer :account_users_concerns do |app|
      ActionController::Base.send(:include, AccountUsers::ActionControllerConcern)
      ActiveModel::Model.send(:include, AccountUsers::ActiveModelConcern)
    end
    
    initializer :account_users_migrations do |app|
      config.paths['db/migrate'].expanded.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer :account_users_autoload_paths do |app|
      app.config.autoload_paths += %W(#{config.root}/app/presenters) 
    end
  
  end
end
