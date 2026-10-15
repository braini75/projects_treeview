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
  # A project together with its visible subprojects.
  TreeNode = Struct.new(:project, :children)

  # Renders +projects+ (the projects visible to the user, in any order) as nested,
  # collapsible lists built on <details>/<summary>.
  #
  # All user-controlled text goes through link_to/content_tag, which escape it.
  def render_projects_tree(projects)
    roots = projects_tree_nodes(projects)
    return ''.html_safe if roots.empty?

    content_tag(:ul, render_projects_tree_nodes(roots), :class => 'projects-tree')
  end

  # Builds the hierarchy from the nested set (lft/rgt). A project whose parent is
  # not in the list (e.g. the parent is not visible to the user) becomes a root.
  def projects_tree_nodes(projects)
    roots = []
    stack = []
    projects.sort_by(&:lft).each do |project|
      stack.pop while stack.any? && !project.is_descendant_of?(stack.last.project)
      node = TreeNode.new(project, [])
      (stack.empty? ? roots : stack.last.children) << node
      stack << node
    end
    roots
  end

  def render_projects_tree_nodes(nodes)
    safe_join(nodes.map { |node| render_projects_tree_node(node) })
  end

  def render_projects_tree_node(node)
    project = node.project
    link = link_to(project.name, project_path(project),
                   :class => (project.closed? ? 'project-closed' : nil))
    if node.children.empty?
      content_tag(:li, link, :class => 'leaf')
    else
      summary = content_tag(:summary, link)
      children = content_tag(:ul, render_projects_tree_nodes(node.children))
      content_tag(:li, content_tag(:details, safe_join([summary, children])), :class => 'folder')
    end
  end
end
