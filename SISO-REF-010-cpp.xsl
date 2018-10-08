<?xml version="1.0"?>
<!--
Copyright (c) 2011, 2013, 2018 by the Simulation Interoperability Standards Organization, Inc.

P.O. Box 781238
Orlando, FL 32878-1238, USA
All rights reserved.

Schema and API: SISO hereby grants a general, royalty-free license to copy, distribute, display, and
make derivative works from this material, for all purposes, provided that any use of the material
contains the following attribution: Reprinted with permission from SISO Inc. Should
a reader require additional information, contact the SISO Inc. Board of Directors.

Documentation: SISO hereby grants a general, royalty-free license to copy, distribute,
display, and make derivative works from this material, for noncommercial purposes, provided that
any use of the material contains the following attribution: Reprinted with permission from SISO Inc. The material may not be used for a commercial purpose without express written
permission from the SISO Inc Board of Directors.

SISO Inc. Board of Directors
P.O. Box 781238
Orlando, FL 32878-1238, USA

  @file siso-ref-010-cpp.xsl
  Transform EBV-MR XML data file into C++ Header (.h) file
  v2.0 12 Apr 2018
  unpdated by David Ronnfeldt <david.ronnfeldt2@defence.gov.au>
  @author Peter Ross <peter.ross@dsto.defence.gov.au>

-->
<!-- <xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:siso="http://www.sisostds.org/schemas/SISO-REF-010/2.4"
    xmlns:func="https://www.w3schools.com/func"
    extension-element-prefixes="func"
    version="1.0"> -->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:siso="http://www.sisostds.org/schemas/SISO-REF-010/2.4"
	xmlns:func="http://www.sisostds.org/functions"
    version="2.0">

  <!-- <xsl:import href="extensions.xsl"/> -->
  <xsl:output method="text" encoding="utf-8" media-type="text/plain"/>

  <xsl:template match="siso:ebv">
    <xsl:text>/**&#xA;</xsl:text>
    <xsl:text> * @file    SisoEnums.h&#xA;</xsl:text>
    <xsl:text> * @brief   </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * @version </xsl:text><xsl:value-of select="@title"/><xsl:text> - </xsl:text><xsl:value-of select="@release"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * @date    </xsl:text><xsl:value-of select="@date"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * @author  </xsl:text><xsl:value-of select="@organization"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> */&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>#ifndef SISO_REF_010_H&#xA;</xsl:text>
    <xsl:text>#define SISO_REF_010_H&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>/** Define an top-level SISO namespace. */&#xA;</xsl:text>
    <xsl:text>namespace SISO {&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="siso:enum|siso:cet"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>} /** End SISO namespace */&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>#endif /* SISO_REF_010_H */&#xA;</xsl:text>
  </xsl:template>

  <!-- Define a function to capitalize and remove special characters from a string. -->
  <xsl:function name="func:captializeString">
	<xsl:param name="unformattedString"/>
    <xsl:value-of select="translate($unformattedString, ' !&quot;#$%&amp;()*+,-./:;&lt;=&gt;?@[\]^`abcdefghijklmnopqrstuvwxyz{|}~', 
		'___________________________ABCDEFGHIJKLMNOPQRSTUVWXYZ____')"/>
  </xsl:function>
  
  <!-- Define a function to print the list of EntityType values in an enum definition. -->
  <xsl:function name="func:listEntityTypeEnums">
	<xsl:param name="enumName"/>
	<xsl:param name="namespacedEnumName"/>
	<xsl:param name="kind"/>
	<xsl:param name="domain"/>
	<xsl:param name="country"/>
	<xsl:param name="category"/>
	<xsl:param name="subcategory"/>
	<xsl:param name="specific"/>
	<xsl:param name="extra"/>
	<!-- Print a comment listing the namespace for the enumeration. -->
	<xsl:text>        /** </xsl:text>
	<xsl:value-of select="$namespacedEnumName"/>
	<xsl:text>_E */&#xA;</xsl:text>
	<xsl:text>        enum </xsl:text>
	<xsl:value-of select="$enumName"/>
	<!-- Append an "_E" after the enumeration name. -->
	<xsl:text>_E {&#xA;</xsl:text>
	<xsl:text>          KIND = </xsl:text>
	<xsl:value-of select="$kind"/>
	<xsl:text>&#xA;          DOMAIN = </xsl:text>
	<xsl:value-of select="$domain"/>
	<xsl:text>&#xA;          COUNTRY = </xsl:text>
	<xsl:value-of select="$country"/>
	<xsl:text>&#xA;          CATEGORY = </xsl:text>
	<xsl:value-of select="$category"/>
	<xsl:text>&#xA;          SUBCATEGORY = </xsl:text>
	<xsl:value-of select="$subcategory"/>
	<xsl:text>&#xA;          SPECIFIC = </xsl:text>
	<xsl:value-of select="$specific"/>
	<xsl:text>&#xA;          EXTRA = </xsl:text>
	<xsl:value-of select="$extra"/>
	<xsl:text>&#xA;        };&#xA;</xsl:text>
  </xsl:function> 
  
<!--
  Define a template to match each Complex Entity Type (CET) element in the SISO-REF-010 XML file.
-->
  <xsl:template match="siso:cet">
    <xsl:text>namespace </xsl:text>
	<xsl:value-of select="func:captializeString(@name)"/>
	<xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates select="siso:entity">
	<xsl:with-param name="namespaceString" 
		  select="concat('SISO::', func:captializeString(@name))" tunnel="yes"/>
	</xsl:apply-templates>
    <xsl:text>}&#xA;</xsl:text>
  </xsl:template>
  
<!--
  Define a template to match each 'entity' (or Kind, Domain, Country) combination in the XML file.
-->
  <xsl:template match="siso:entity">
    <xsl:param name="namespaceString" tunnel="yes"/>
	<xsl:variable name="kindDomainCountryVal" select="concat(@kind, '_', @domain, '_', @country)"/>
    <xsl:text>  namespace </xsl:text>
    <xsl:value-of select="$kindDomainCountryVal"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates select="siso:category">
	  <xsl:with-param name="namespaceString" 
		  select="concat($namespaceString, '::', $kindDomainCountryVal)" tunnel="yes"/>
	  <xsl:with-param name="kindNum" select="@kind" tunnel="yes"/>
	  <xsl:with-param name="domainNum" select="@domain" tunnel="yes"/>
	  <xsl:with-param name="countryNum" select="@country" tunnel="yes"/>
	</xsl:apply-templates>
    <xsl:text>  }&#xA;</xsl:text>
  </xsl:template>

<!--
  Define a template to match each 'category' in the XML file.
-->
  <xsl:template match="siso:category">
    <xsl:param name="namespaceString" tunnel="yes"/>
    <xsl:param name="kindNum" tunnel="yes"/>
    <xsl:param name="domainNum" tunnel="yes"/>
    <xsl:param name="countryNum" tunnel="yes"/>
	<xsl:variable name="curCategoryName" select="func:captializeString(@description)"/>
	<!-- Choose to apply-templates for EntityTypes, otherwise print enums. -->
	<xsl:choose>
	  <!-- Just print the enumerations in AGGREGATE_STATE_AGGREGATE_TYPES case. -->
	  <xsl:when test="$namespaceString = 'SISO::AGGREGATE_STATE_AGGREGATE_TYPES::1_1_225'">
		<xsl:value-of select="func:listEntityTypeEnums($curCategoryName, 
			concat($namespaceString, '::', $curCategoryName), 
			$kindNum, $domainNum, $countryNum, @value, 0, 0, 0)"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <!-- Apply templates again for EntityTypes, to get subcategories. -->
		<xsl:text>    namespace </xsl:text>
		<xsl:value-of select="$curCategoryName"/>
		<xsl:text> {&#xA;</xsl:text>	  
		<xsl:apply-templates select="siso:subcategory">
		  <xsl:with-param name="namespaceString" 
			  select="concat($namespaceString, '::', $curCategoryName)" tunnel="yes"/>	
		  <xsl:with-param name="kindNum" select="$kindNum" tunnel="yes"/>
		  <xsl:with-param name="domainNum" select="$domainNum" tunnel="yes"/>
		  <xsl:with-param name="countryNum" select="$countryNum" tunnel="yes"/>	
		  <xsl:with-param name="categoryNum" select="@value" tunnel="yes"/>
		</xsl:apply-templates>
		<xsl:text>    }&#xA;</xsl:text>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
<!--
  Define a template to match each 'subcategory' in the XML file.
-->
  <xsl:template match="siso:subcategory">
    <xsl:param name="namespaceString" tunnel="yes"/>
    <xsl:param name="kindNum" tunnel="yes"/>
    <xsl:param name="domainNum" tunnel="yes"/>
    <xsl:param name="countryNum" tunnel="yes"/>
    <xsl:param name="categoryNum" tunnel="yes"/>
	<!-- Get the subcategory name. -->
	<xsl:variable name="curSubcategoryName" select="func:captializeString(@description)"/>
	<!-- Get the fully-namespaced subcategory name. -->
	<xsl:variable name="namespacedSubcategoryName" 
		select="concat($namespaceString, '::', $curSubcategoryName)"/>
    <xsl:text>      namespace </xsl:text>
    <xsl:value-of select="$curSubcategoryName"/>
    <xsl:text> {&#xA;</xsl:text>
	<!-- Print the EntityType enums for this subcategory. -->
	<xsl:value-of select="func:listEntityTypeEnums($curSubcategoryName, 
	    concat($namespacedSubcategoryName, '::', $curSubcategoryName), 
		$kindNum, $domainNum, $countryNum, $categoryNum, @value, 0, 0)"/>
    <xsl:apply-templates select="siso:specific">
	  <xsl:with-param name="namespaceString" 
		  select="$namespacedSubcategoryName" tunnel="yes"/>		
	  <xsl:with-param name="kindNum" select="$kindNum" tunnel="yes"/>
	  <xsl:with-param name="domainNum" select="$domainNum" tunnel="yes"/>
	  <xsl:with-param name="countryNum" select="$countryNum" tunnel="yes"/>	
	  <xsl:with-param name="categoryNum" select="$categoryNum" tunnel="yes"/>
	  <xsl:with-param name="subcategoryNum" select="@value" tunnel="yes"/>
	</xsl:apply-templates>	  
    <xsl:text>      }&#xA;</xsl:text>
  </xsl:template>
  
<!--
  Define a template to match each 'specific' in the XML file.
-->
  <xsl:template match="siso:specific">
    <xsl:param name="namespaceString" tunnel="yes"/>
    <xsl:param name="kindNum" tunnel="yes"/>
    <xsl:param name="domainNum" tunnel="yes"/>
    <xsl:param name="countryNum" tunnel="yes"/>
    <xsl:param name="categoryNum" tunnel="yes"/>
    <xsl:param name="subcategoryNum" tunnel="yes"/>
	<!-- Get the specific name. -->
	<xsl:variable name="curSpecificName" select="func:captializeString(@description)"/>
	<!-- Get the fully-namespaced specific name. -->
	<xsl:variable name="namespacedSpecificName" 
		select="concat($namespaceString, '::', $curSpecificName)"/>
	<!-- Print the EntityType enums for this specific. -->
	<xsl:value-of select="func:listEntityTypeEnums($curSpecificName, $namespacedSpecificName,
		$kindNum, $domainNum, $countryNum, $categoryNum, $subcategoryNum, @value, 0)"/>
    <xsl:apply-templates select="siso:extra">
	  <xsl:with-param name="namespaceString" 
		  select="$namespacedSpecificName" tunnel="yes"/>
	  <xsl:with-param name="kindNum" select="$kindNum" tunnel="yes"/>
	  <xsl:with-param name="domainNum" select="$domainNum" tunnel="yes"/>
	  <xsl:with-param name="countryNum" select="$countryNum" tunnel="yes"/>	
	  <xsl:with-param name="categoryNum" select="$categoryNum" tunnel="yes"/>
	  <xsl:with-param name="subcategoryNum" select="$subcategoryNum" tunnel="yes"/>
	  <xsl:with-param name="specificNum" select="@value" tunnel="yes"/>
	</xsl:apply-templates>	  
  </xsl:template>
  
<!--
  Define a template to match each 'extra' in the XML file.
-->
  <xsl:template match="siso:extra">
    <xsl:param name="namespaceString" tunnel="yes"/>
    <xsl:param name="kindNum" tunnel="yes"/>
    <xsl:param name="domainNum" tunnel="yes"/>
    <xsl:param name="countryNum" tunnel="yes"/>
    <xsl:param name="categoryNum" tunnel="yes"/>
    <xsl:param name="subcategoryNum" tunnel="yes"/>  
    <xsl:param name="specificNum" tunnel="yes"/>  
	<!-- Get the extra name. -->
	<xsl:variable name="curExtraName" select="func:captializeString(@description)"/>
	<!-- Get the fully-namespaced extra name. -->
	<xsl:variable name="namespacedExtraName" 
		select="concat($namespaceString, '::', $curExtraName)"/>	
	<xsl:value-of select="func:listEntityTypeEnums($curExtraName, $namespacedExtraName, 
		$kindNum, $domainNum, $countryNum, $categoryNum, $subcategoryNum, $specificNum, @value)"/>
  </xsl:template>
	
<!--
  Define a template to match each enum element in the XML file.
-->
  <xsl:template match="siso:enum">
    <xsl:text>enum </xsl:text>
    <xsl:value-of select="func:captializeString(@name)"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates select="siso:enumrow"/>
    <xsl:text>};&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
  
<!--
  Define a template to match each enum/enumrow element in the XML file.
-->
  <xsl:template match="siso:enumrow">
    <xsl:text>    </xsl:text>
	<!-- Define the variable based on the value of "description". -->
	<xsl:variable name="enumRowName">
	  <xsl:choose>
		<xsl:when test="(@description = '') or (@description = ' ')">
		  <xsl:value-of select="./siso:meta/@value"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@description"/>
		</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
    <!-- Define a variable to store the capitalized name with all special characters removed, except apostrophes. -->
	<xsl:variable name="cleaned_name" select="func:captializeString($enumRowName)"/>
    <!-- Remove quotes then apply the formatted name to the template. -->
    <xsl:value-of select='translate($cleaned_name, "&apos;", "")'/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:if test="position()!=last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
  <xsl:template match="text()"/>
</xsl:stylesheet>
