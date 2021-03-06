require "eisiges/di/core/version"

module Eisiges
	module DI
		module Core
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
					((@@injections ||= {})[self] ||= {})[as] = args[:klasse]
				end

				base.define_singleton_method(:factory_for) do |klasse=nil, dependencies:, &block| #klasse, dependencies: {varName: Class, varName: Class}, blck: $block_goes_here
					(@@inst_factories ||= {})[klasse] = {dependencies: dependencies, block: block}
				end

				base.define_singleton_method(:instance_factory) do
					(@@inst_factories ||= {})[self]
				end

				base.define_singleton_method(:has_instance_factory?) do
					return (not self.instance_factory.nil?)
				end

				#shareable
				base.define_singleton_method(:shareable) do |args| #in_scope: :request (:once/:never, :request, :session, :user, :global)
					(@@shareable ||= {})[self] = (args ||= {})
				end

				#shareable?
				base.define_singleton_method(:shareable?) do
					((@@shareable ||= {})[self] || false) # if it isn't defined, just say it can't be shared
				end
				#is_shareable?
				base.define_singleton_method(:is_shareable?) do
					self.shareable?
				end

				#get_injection_points
				base.define_singleton_method(:get_injection_points) do
					h = {}
					h = h.merge(self.superclass.get_injection_points) if self.superclass.respond_to?(:get_injection_points)
					h.merge ((@@injections ||= {})[self] ||= {})
				end

				base.define_singleton_method(:dependencies) do
					self.get_injection_points
				end
			end
		end
	end
end

Eisiges::DI::Core.build_class Object #Register these methods with every single class

