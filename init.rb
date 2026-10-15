Redmine::Plugin.register :projects_treeview do
  name 'Projects Treeview plugin'
  author 'Thomas Koch (fork: Sostenido)'
  description 'This Plugin offers a tree view for browsing projects.'
  version '0.5.0'
  requires_redmine :version_or_higher => '5.0.0'
  url 'https://github.com/sostenido/projects_treeview'
  author_url 'https://github.com/braini75'

  menu :top_menu, :projects_treeview, { :controller => 'treeview', :action => 'index' }, :caption => :projects_treeview_title
end
