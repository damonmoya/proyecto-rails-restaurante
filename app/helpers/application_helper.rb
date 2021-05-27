module ApplicationHelper
    def sortable(column, title)
        sort_column = params[:sort] || "email"
        sort_direction = params[:direction] || "asc"
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction}
    end

    def sortable_mybooks(column, title)
        sort_column = params[:sort] || "email"
        sort_direction = params[:direction] || "asc"
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction, :token => params[:token]}
    end
end
