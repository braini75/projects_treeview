#Copyright (c) 2014 Paul Kertscher
#Permission is hereby granted, free of charge, to any person obtaining a copy of
#this software and associated documentation files (the "Software"), to deal in 
#the Software without restriction, including without limitation the rights to 
#use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
#of the Software, and to permit persons to whom the Software is furnished to do 
#so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all 
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
#SOFTWARE.
#
#
#The original css tree menu is based on a work of Ryan Seddon, presented in his 
#blog (see http://www.thecssninja.com/css/css-tree-menu)

module TreeviewHelper
#implements the treeview presented ar http://www.thecssninja.com/css/css-tree-menu

  def render_projects_tree(projects)
    s = ''
    if projects.any?
      s << "<ol class='tree'>"
      ancestors = Array.new
      original_project = @project
      last_project = nil

      projects.sort_by(&:lft).each do |project|
	  
        # @project = project
        # if (ancestors.empty? || project.is_descendant_of?(ancestors.last))
          # s << "<ul class='projects #{ ancestors.empty? ? 'root' : nil}'>\n"
        # else
          # ancestors.pop
          # s << "</li>"
          # while (ancestors.any? && !last_project.is_descendant_of?(ancestors.last))
            # ancestors.pop
            # s << "</ul></li>\n"
          # end
        # end
        # classes = (ancestors.empty? ? 'root' : 'child')
        
		
        # s << "</div>\n"
        if !(last_project == nil)
		  nols = 0
		
		  
		
		  if project.is_descendant_of?(last_project)
			s << "<li>"
			s << "<label for='subfolder"
			s << last_project.identifier 
			s << "'>"
			s << "<a href='./projects/"
			s << last_project.identifier
			s << "'>"
			s << last_project.name
			s << "</a></label>"
			s << "<input type='checkbox' id='" 
			s << last_project.identifier
			s << "' />"
			s << "<ol>" # starte neue Unterliste
		  else
			s << "<li class='file'>"
			s << "<a href='./projects/"
			s << last_project.identifier
			s << "'>"
			s << last_project.name
		    s << "</a></li>"
		  end
		  
		  
		  
		  # s << "<li><div class='#{classes}'>"
		
		
          # s << h(block_given? ? yield(last_project) : last_project.name)
		  
		  # s << "<a href='../projects/'"
		  # s << last_project.identifier
		  # s << "'>"
		  # s << last_project.name
		  # s << "</a>"
		
          ancestors.push(last_project)
		  
		  while ancestors.any? && !project.is_descendant_of?(ancestors.last)
			ancestors.pop
			nols = nols + 1
		  end
		  
		  nols = nols-2
		  
		  while nols >= 0
			s << "</ol>"
			nols = nols - 1
		  end
        end
		
        last_project = project
      end
      
      # while (ancestors.any? && !project.is_descendant_of?(ancestors.last))
        # ancestors.pop
        # s << "</ol></li>\n"
      # end
	  
	  
      
      # print out last element
	  s << "<li class='file'>"
	  s << "<a href='./projects/"
	  s << last_project.identifier
	  s << "'>"
	  s << last_project.name
	  s << "</a></li>"

      s << ("</ol>\n" * ancestors.size)
      
      s << "</ol>";

      @project = original_project
    end
    s.html_safe

  end
end
