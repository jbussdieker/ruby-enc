module NodesHelper
  def node_report_time(time)
    if time
      time_ago_in_words(time) + " ago"
    else
      "unreported"
    end
  end

  def puppet_agent_node_status(node)
    css = 'default'
    content_tag(:div, class: 'btn-group') do
      content_tag(:button, type: :button, class: "btn btn-#{css} btn-sm dropdown-toggle", 'data-toggle' => :dropdown) do
        "Action ".html_safe + tag(:span, class: :caret)
      end +
      content_tag(:ul, class: 'dropdown-menu', role: 'menu') do
        content_tag(:li, link_to("Highstate", highstate_node_path(node))) +
        content_tag(:li, link_to("Highstate Test", highstate_test_node_path(node)))
      end
    end
  end

  def node_status_badge(node)
    if node.status
      case node.status
        when "changed"
          content_tag(:span, node.status, :class => 'label label-info')
        when "pending"
          content_tag(:span, node.status, :class => 'label label-warning')
        when "unchanged"
          content_tag(:span, node.status, :class => 'label label-success')
        when "failed"
          content_tag(:span, node.status, :class => 'label label-danger')
      end
    else
      content_tag(:span, "unreported", :class => 'label label-default')
    end
  end
end
