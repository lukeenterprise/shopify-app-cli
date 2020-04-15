# frozen_string_literal: true

require "test_helper"

ShopifyCli::ProjectType.load_type(:script)

describe Script::Layers::Infrastructure::ExtensionPointRepository do
  subject { Script::Layers::Infrastructure::ExtensionPointRepository.new }

  describe ".get_extension_point" do
    describe "when the extension point is configured" do
      Script::Layers::Infrastructure::ExtensionPointRepository.new
        .send(:extension_points)
        .each do |extension_point_type, _config|
        it "should be able to load the #{extension_point_type} extension point" do
          extension_point = subject.get_extension_point(extension_point_type)
          assert_equal extension_point_type, extension_point.type
          refute_nil extension_point.sdks[:ts].package
          refute_nil extension_point.sdks[:ts].version
          refute_nil extension_point.sdks[:ts].sdk_version
        end
      end
    end

    describe "when the extension point does not exist" do
      let(:bogus_extension) { "bogus" }

      it "should raise Domain::InvalidExtensionPointError" do
        assert_raises(Script::Layers::Domain::InvalidExtensionPointError) do
          subject.get_extension_point(bogus_extension)
        end
      end
    end
  end

  describe ".extension_point_types" do
    it 'should return the ep keys' do
      subject.stubs(:extension_points).returns({
                                                 "discount" => {},
                                                 "other" => {},
                                               })
      assert_equal ['discount', 'other'], subject.send(:extension_point_types)
    end
  end
end
