<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.springframework.core.io.Resource"%>
<%@page import="org.springframework.core.io.ClassPathResource"%>
<%@page import="org.springframework.core.io.support.PropertiesLoaderUtils"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.OutputFormat"%>
<%@page import="org.dom4j.io.XMLWriter"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%@page import="net.shop.CommonAttributes"%>
<%@page import="net.shop.util.JsonUtils"%>
<%@include file="common.jsp"%>
<%
	Boolean isAgreeAgreement = (Boolean) session.getAttribute("isAgreeAgreement");
	if (isAgreeAgreement == null || !isAgreeAgreement) {
		response.sendRedirect("index.jsp");
		return;
	}

	String databaseType = (String) session.getAttribute("databaseType");
	String databaseHost = (String) session.getAttribute("databaseHost");
	String databasePort = (String) session.getAttribute("databasePort");
	String databaseUsername = (String) session.getAttribute("databaseUsername");
	String databasePassword = (String) session.getAttribute("databasePassword");
	String databaseName = (String) session.getAttribute("databaseName");
	String locale = (String) session.getAttribute("locale");

	String status = "success";
	String message = "";
	String exception = "";

	if (StringUtils.isEmpty(databaseType)) {
		status = "error";
		message = "数据库类型不允许为空!";
	} else if (StringUtils.isEmpty(databaseHost)) {
		status = "error";
		message = "数据库主机不允许为空!";
	} else if (StringUtils.isEmpty(databasePort)) {
		status = "error";
		message = "数据库端口不允许为空!";
	} else if (StringUtils.isEmpty(databaseUsername)) {
		status = "error";
		message = "数据库用户名不允许为空!";
	} else if (StringUtils.isEmpty(databaseName)) {
		status = "error";
		message = "数据库名称不允许为空!";
	} else if (StringUtils.isEmpty(locale)) {
		status = "error";
		message = "语言不允许为空!";
	}

	String jdbcDriver = null;
	String jdbcUrl = null;
	Integer databaseMajorVersion = null;
	Integer databaseMinorVersion = null;
	String hibernateDialect = null;

	if (status.equals("success")) {
		if (databaseType.equalsIgnoreCase("mysql")) {
			jdbcDriver = "com.mysql.jdbc.Driver";
			Connection connection = null;
			try {
				jdbcUrl = "jdbc:mysql://" + databaseHost + ":" + databasePort + "/" + databaseName + "?useUnicode=true&characterEncoding=" + DATABASE_ENCODING;
				connection = DriverManager.getConnection(jdbcUrl, databaseUsername, databasePassword);
			} catch (SQLException e) {
				jdbcUrl = "jdbc:mysql://" + databaseHost + ":" + databasePort + "/" + databaseName + "?useUnicode=true";
			} finally {
				try {
					if (connection != null) {
						connection.close();
						connection = null;
					}
				} catch (SQLException e) {
				}
			}
		} else if (databaseType.equalsIgnoreCase("sqlserver")) {
			jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
			jdbcUrl = "jdbc:sqlserver://" + databaseHost + ":" + databasePort + ";databasename=" + databaseName;
		} else if (databaseType.equalsIgnoreCase("oracle")) {
			jdbcDriver = "oracle.jdbc.OracleDriver";
			jdbcUrl = "jdbc:oracle:thin:@" + databaseHost + ":" + databasePort + ":" + databaseName;
		} else {
			status = "error";
			message = "参数错误!";
		}
	}

	if (status.equals("success")) {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(jdbcUrl, databaseUsername, databasePassword);
			DatabaseMetaData databaseMetaData = connection.getMetaData();
			databaseMajorVersion = databaseMetaData.getDatabaseMajorVersion();
			databaseMinorVersion = databaseMetaData.getDatabaseMinorVersion();
		} catch (SQLException e) {
			status = "error";
			message = "JDBC执行错误!";
			exception = stackToString(e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
					connection = null;
				}
			} catch (SQLException e) {
				status = "error";
				message = "JDBC执行错误!";
				exception = stackToString(e);
			}
		}
	}

	if (status.equals("success")) {
		if (databaseType.equalsIgnoreCase("mysql")) {
			hibernateDialect = "org.hibernate.dialect.MySQLDialect";
		} else if (databaseType.equalsIgnoreCase("sqlserver")) {
			if (databaseMajorVersion == 9) {
				hibernateDialect = "org.hibernate.dialect.SQLServer2005Dialect";
			} else if (databaseMajorVersion == 10) {
				hibernateDialect = "org.hibernate.dialect.SQLServer2008Dialect";
			} else {
				hibernateDialect = "org.hibernate.dialect.SQLServerDialect";
			}
		} else if (databaseType.equalsIgnoreCase("oracle")) {
			if (databaseMajorVersion == 8) {
				hibernateDialect = "org.hibernate.dialect.Oracle8iDialect";
			} else if (databaseMajorVersion == 9) {
				hibernateDialect = "org.hibernate.dialect.Oracle9Dialect";
			} else if (databaseMajorVersion == 10) {
				hibernateDialect = "org.hibernate.dialect.Oracle10gDialect";
			} else if (databaseMajorVersion == 11) {
				hibernateDialect = "org.hibernate.dialect.Oracle10gDialect";
			} else {
				hibernateDialect = "org.hibernate.dialect.OracleDialect";
			}
		}

		try {
			Resource resource = new ClassPathResource(CommonAttributes.SHOPXX_PROPERTIES_PATH);
			Properties properties = PropertiesLoaderUtils.loadProperties(resource);
			properties.setProperty("system.project_name", (request.getServerName() + request.getContextPath()).replaceAll("\\.|\\-|\\\\|\\/", "_"));
			properties.setProperty("locale", locale);
			properties.setProperty("jdbc.driver", jdbcDriver);
			properties.setProperty("jdbc.url", jdbcUrl);
			properties.setProperty("jdbc.username", databaseUsername);
			properties.setProperty("jdbc.password", databasePassword);
			properties.setProperty("hibernate.dialect", hibernateDialect);
			OutputStream outputStream = new FileOutputStream(resource.getFile());
			properties.store(outputStream, "SHOP++ PROPERTIES");
			outputStream.close();
		} catch (IOException e) {
			status = "error";
			message = "SHOPXX.PROPERTIES文件写入失败!";
			exception = stackToString(e);
		}
	}

	if (status.equals("success")) {
		try {
			File shopxxXmlFile = new ClassPathResource(CommonAttributes.SHOPXX_XML_PATH).getFile();
			Document document = new SAXReader().read(shopxxXmlFile);
			Element siteUrlElement = (Element) document.selectSingleNode("/shopxx/setting[@name='siteUrl']");
			Element logoElement = (Element) document.selectSingleNode("/shopxx/setting[@name='logo']");
			Element defaultLargeProductImageElement = (Element) document.selectSingleNode("/shopxx/setting[@name='defaultLargeProductImage']");
			Element defaultMediumProductImageElement = (Element) document.selectSingleNode("/shopxx/setting[@name='defaultMediumProductImage']");
			Element defaultThumbnailProductImageElement = (Element) document.selectSingleNode("/shopxx/setting[@name='defaultThumbnailProductImage']");
			String siteUrl;
			if (request.getServerPort() == 80) {
				siteUrl = request.getScheme() + "://" + request.getServerName() + request.getContextPath();
			} else {
				siteUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
			}
			siteUrlElement.attribute("value").setValue(siteUrl);
			logoElement.attribute("value").setValue(request.getContextPath() + "/upload/image/logo.gif");
			defaultLargeProductImageElement.attribute("value").setValue(request.getContextPath() + "/upload/image/default_large.jpg");
			defaultMediumProductImageElement.attribute("value").setValue(request.getContextPath() + "/upload/image/default_medium.jpg");
			defaultThumbnailProductImageElement.attribute("value").setValue(request.getContextPath() + "/upload/image/default_thumbnail.jpg");

			FileOutputStream fileOutputStream = null;
			XMLWriter xmlWriter = null;
			try {
				OutputFormat outputFormat = OutputFormat.createPrettyPrint();
				outputFormat.setEncoding("UTF-8");
				outputFormat.setIndent(true);
				outputFormat.setIndent("	");
				outputFormat.setNewlines(true);
				fileOutputStream = new FileOutputStream(shopxxXmlFile);
				xmlWriter = new XMLWriter(fileOutputStream, outputFormat);
				xmlWriter.write(document);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (xmlWriter != null) {
					try {
						xmlWriter.close();
					} catch (IOException e) {
					}
				}
				IOUtils.closeQuietly(fileOutputStream);
			}
		} catch (IOException e) {
			status = "error";
			message = "SHOPXX_XML文件写入失败!";
			exception = stackToString(e);
		}
	}

	if (status.equals("success")) {
		try {
			FileUtils.writeStringToFile(new File(rootPath + INSTALL_LOCK_CONFIG_PATH), "SHOP++ INSTALL LOCK - SHOPXX.NET");
		} catch (IOException e) {
			status = "error";
			message = "INSTALL_LOCK.CONFIG文件写入失败!";
			exception = stackToString(e);
		}
	}

	if (status.equals("success")) {
		try {
			File webXmlSampleFile = new File(rootPath + WEB_XML_SAMPLE_PATH);
			File webXmlFile = new File(rootPath + WEB_XML_PATH);
			String webXmlSampleString = FileUtils.readFileToString(webXmlSampleFile);
			FileUtils.writeStringToFile(webXmlFile, webXmlSampleString);
		} catch (IOException e) {
			status = "error";
			message = "WEB.XML文件写入失败!";
			exception = stackToString(e);
		}
	}

	if (status.equals("success")) {
		try {
			FileUtils.writeStringToFile(new File(rootPath + INSTALL_INIT_CONFIG_PATH), "SHOP++ INSTALL INIT - SHOPXX.NET");
			FileUtils.deleteQuietly(new File(rootPath + INDEX_JSP_PATH));
		} catch (IOException e) {
			status = "error";
			message = "INSTALL_INIT.CONFIG文件写入失败!";
			exception = stackToString(e);
		}
	}

	Enumeration<Driver> drivers = DriverManager.getDrivers();
	while (drivers.hasMoreElements()) {
		Driver driver = drivers.nextElement();
		try {
			DriverManager.deregisterDriver(driver);
		} catch (SQLException e) {

		}
	}

	Map<String, String> data = new HashMap<String, String>();
	data.put("status", status);
	data.put("message", message);
	data.put("exception", exception);
	JsonUtils.writeValue(response.getWriter(), data);
%>