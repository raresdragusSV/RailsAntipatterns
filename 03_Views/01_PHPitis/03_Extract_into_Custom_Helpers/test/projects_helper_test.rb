require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase
  context 'the rss_link method' do
    setup do
      @result = rss_link(@project)
    end

    should 'include a link to the alerts_rss_url' do
      assert_match /href="#{alerts_rss_url}"/, @result
    end

    should 'include a div with the class feed' do
      assert_match /div class="feed"/, @result
    end

    should 'include an A tag with the class feed_link' do
      assert_match /a class="feed_link"/, @result
    end
  end

  context 'with a project' do
    setup do
      @project = Factory(:project)
    end

    context 'the rss_link method' do
      setup do
        @result = rss_link(@project)
      end

      should 'have the project name in the rss link' do
        assert_match /Subscribe to these #{@project.name} alerts/,
                     @result
      end

      should 'include a link to the rss for the project' do
        assert_match /href="#{alerts_rss_url(@project)}"/,
                     @result
      end
    end
  end

  context 'the alerts_rss_url method' do
    setup do
      @result = alerts_rss_url
    end

    should 'return the rss alerts url' do
      assert_equal alerts_url(:rss), @result
    end
  end

  context 'with a project' do
    setup do
      @project = Factory(:project)
    end

    context 'the alerts_rss_url method' do
      setup do
        @result = alerts_rss_url(@project)
      end

      should 'return the rss project alerts url' do
        assert_equal project_alerts_url(@project, format: :rss),
                     @result
      end
    end
  end
end
