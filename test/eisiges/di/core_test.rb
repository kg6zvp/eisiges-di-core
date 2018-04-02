require 'test_helper'

class Eisiges::DI::CoreTest < Minitest::Test
	def test__that_it_has_a_version_number
		refute_nil ::Eisiges::DI::Core::VERSION
	end

	def test__it_can_list_dependencies_in_example
		assert_equal({:so => ServiceObject}, DiExample.dependencies)
		assert_equal({:so => ServiceObject}, DiExample.get_injection_points)

		assert_equal({:so => ServiceObject}, InheritedEx.dependencies)
		assert_equal({:so => ServiceObject}, InheritedEx.get_injection_points)
		assert_equal({:so => ServiceObject, :my_date => MyDate}, OtherInheritedEx.dependencies)
		assert_equal({:so => ServiceObject, :my_date => MyDate}, OtherInheritedEx.get_injection_points)

		assert_equal({}, MyDate.dependencies)
		assert_equal({}, MyDate.get_injection_points)
		assert_equal({}, ServiceObject.dependencies)
		assert_equal({}, ServiceObject.get_injection_points)
	end

	def test__it_can_express_shareability
		refute_nil DiExample.shareable?
		refute_nil ServiceObject.shareable?

		refute DiExample.shareable?
		assert_equal :my_scope, ServiceObject.shareable?
	end

	def test__it_can_show_providers_in_example
		assert ThirdPartyLib.has_instance_factory?
		refute_nil ThirdPartyLib.instance_factory
		assert_equal({:so => ServiceObject}, ThirdPartyLib.instance_factory[:dependencies])
		refute_nil ThirdPartyLib.instance_factory[:block]
		assert_nil ThirdPartyWithHash.instance_factory[:block]

		refute DiExample.has_instance_factory?
	end
end

