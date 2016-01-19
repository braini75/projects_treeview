Redmine::Plugin.register :projects_treeview do
  name 'Projects Treeview plugin'
  author 'Thomas Koch'
  description 'This Plugin offers a tree view for browsing projects.'
  version '0.2'
  url 'https://github.com/braini75/projects_treeview.git' 
  author_url 'https://github.com/braini75' 
  
  menu :top_menu, :projects_treeview, { :controller => 'treeview', :action => 'index' }, :caption => :projects_treeview_title
end
