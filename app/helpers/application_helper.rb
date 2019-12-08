module ApplicationHelper
    include AdminHelper
    
    # USED: start of each view template
    def title(text)
        content_for :title, text || "Wandering"
    end

    
end
