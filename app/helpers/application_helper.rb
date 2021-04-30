module ApplicationHelper
    def sortable(column, title)
        sort_column = params[:sort] || "email"
        sort_direction = params[:direction] || "asc"
        css_class = column == sort_column ? "current {#sort_direction}" : nil
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end
end
