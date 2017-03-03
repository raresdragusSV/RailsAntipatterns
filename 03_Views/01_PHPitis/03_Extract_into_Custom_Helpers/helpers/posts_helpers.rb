def rss_link(project = nil)
  if project
    link_to "Subscribe to #{project.name} alerts.",
            project_alerts_url(project, format: :rss),
            class: 'feed_link'
  else
    link_to 'Subscribe to these alerts.',
            alerts_url(format: :rss),
            class: 'feed_link'
  end
end

# refactoring

def alerts_rss_url(project = nil)
  if project
    project_alerts_url(project, format: :rss)
  else
    alerts_url(:rss)
  end
end

def rss_link(project = nil)
  link_to "Subscribe to these #{project.name if project} alerts.",
          alerts_rss_url(project),
          class: 'feed_link'
end
