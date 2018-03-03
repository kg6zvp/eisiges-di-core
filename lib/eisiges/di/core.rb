require "eisiges/di/core/version"

module Eisiges
	module DI
		module Core
			#def self.included base
			#	build_class base
			#end

			def self.build_class base
				#puts "included called..."
				#puts base.name #outputs the class that this was mixed into
				
				#get_simple_name
				base.define_singleton_method(:get_simple_name) do |klasse|
					klasse.name.split('::').last
				end

				#inject
				#puts "Performing injection point registration on " + base.name #+self.name
				base.define_singleton_method(:inject) do |args| #klasse, as: nil
					#puts args[:klasse]
					as = args[:as]
					if as == nil
						as = get_simple_name(klasse)
					end
					(@@injections ||= {})[as] = args[:klasse]
				end

				#shareable
				base.define_singleton_method(:shareable) do |args| #in_scope: :request (:once/:never, :request, :session, :user, :global)
					#in_scope = args[:in_scope]
					#case in_scope
					#when :once, :never, :request, :session, :user, :global
						#no need to change it's value because it's valid
					#else
					#	in_scope = :request
					#end

					#@@shareable = in_scope
					
					@@shareable = (args ||= {})
				end

				#shareable?
				base.define_singleton_method(:shareable?) do
					#(@@shareable ||= :request)
					(@@shareable || false) # if it isn't defined, just say it can't be shared
				end
				#is_shareable?
				base.define_singleton_method(:is_shareable?) do
					self.shareable?
				end

				#get_injection_points
				base.define_singleton_method(:get_injection_points) do
					(@@injections ||= {})
				end

				base.define_singleton_method(:dependencies) do
					self.get_injection_points
				end
				
				#return base.send :included #really puzzled why this isn't necessary
			end
		end
	end
end

Eisiges::DI::Core.build_class Object #Register these methods with every single class

