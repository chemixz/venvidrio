module PermissionsConcern
	extend ActiveSupport::Concern
		
		def is_admin?
			self.role >= 2
		end

        def is_super?
            self.role >=3
        end
end