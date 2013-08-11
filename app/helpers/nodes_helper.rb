module NodesHelper
  def node_report_time(time)
    if time
      time_ago_in_words(time) + " ago"
    else
      "unreported"
    end
  end

  def node_status_badge(node)
    if node.status
      case node.status
        when "changed"
          content_tag(:span, node.status, :class => 'badge badge-success')
        when "unchanged"
          content_tag(:span, node.status, :class => 'badge')
        when "failed"
          content_tag(:span, node.status, :class => 'badge badge-important')
      end
    else
      content_tag(:span, "unreported", :class => 'badge')
    end
  end
end
