package org.molgenis.datatable.view;

import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.molgenis.datatable.DataSourceFactory.DataSourceFactoryImpl;
import org.molgenis.datatable.controller.JQGridController;
import org.molgenis.framework.ui.html.HtmlWidget;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

public class JQGridView extends HtmlWidget
{
	private final JQGridController.DataSourceDescription dataSourceDescription; //JSON String that represents the database
	
	public JQGridView(String name, JQGridController.DataSourceDescription dataSource)
	{
		super(name);
		this.dataSourceDescription = dataSource;
	}
	
	
	@Override
	public String toHtml() {
		try
		{
			final Map<String, Object> args = new HashMap<String, Object>();
			
			args.put("tableId", getId());
			args.put("columns", dataSourceDescription.getColumns());
			args.put("dataSourceFactoryClassName", DataSourceFactoryImpl.class.getName());
			args.put("viewFactoryClassName", ViewFactoryImpl.class.getName());
			args.put("backendUrl", "jqGridService.do");
			args.put("sortName", dataSourceDescription.getColumns().get(0).getName());
			args.put("dataSource", dataSourceDescription.toJson());
			
			final Configuration cfg = new Configuration();
			cfg.setObjectWrapper(new DefaultObjectWrapper());
			cfg.setClassForTemplateLoading(JQGridView.class, "");
			final Template template = cfg.getTemplate(JQGridView.class.getSimpleName() + ".ftl");
			final Writer out = new StringWriter();
			template.process(args, out);
			out.flush();  
			return out.toString();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
	}
}