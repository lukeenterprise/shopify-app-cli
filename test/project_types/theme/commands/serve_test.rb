# frozen_string_literal: true
require 'project_types/theme/test_helper'

module Theme
  module Commands
    class ServeTest < MiniTest::Test
      include TestHelpers::FakeUI

      def test_serve_command
        context = ShopifyCli::Context.new
        Themekit.expects(:ensure_themekit_installed).with(context)
        Themekit.expects(:serve).with(context, env: nil)

        Theme::Commands::Serve.new(context).call
      end

      def test_can_specify_env
        context = ShopifyCli::Context.new
        Themekit.expects(:ensure_themekit_installed).with(context)
        Themekit.expects(:serve).with(context, env: 'development')

        command = Theme::Commands::Serve.new(context)
        command.options.flags[:env] = 'development'
        command.call
      end
    end
  end
end
