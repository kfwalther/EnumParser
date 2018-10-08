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
    version="1.0">

  <!-- <xsl:import href="extensions.xsl"/> -->
  <xsl:output method="text" encoding="utf-8" media-type="text/plain"/>

  <xsl:template match="siso:ebv">
    <xsl:text>/*!&#xA;</xsl:text>
    <xsl:text> * \file    siso-ref-010.h&#xA;</xsl:text>
    <xsl:text> * \brief   </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * \version </xsl:text><xsl:value-of select="@title"/><xsl:text> - </xsl:text><xsl:value-of select="@release"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * \date    </xsl:text><xsl:value-of select="@date"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> * \author  </xsl:text><xsl:value-of select="@organization"/><xsl:text>&#xA;</xsl:text>
    <xsl:text> */&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>#ifndef SISO_REF_010_H&#xA;</xsl:text>
    <xsl:text>#define SISO_REF_010_H&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>/*! Loop through all the enums in the file. */&#xA;</xsl:text>
    <xsl:apply-templates match="enum|cet"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>#endif /* SISO_REF_010_H */&#xA;</xsl:text>
  </xsl:template>





Try one big for-loop (nested for each case)










<!--
  Define a template to match each Complex Entity Type (CET) element in the SISO-REF-010 XML file.
-->
  <xsl:template match="siso:cet">
    <xsl:text>namespace EntityType {&#xA;</xsl:text>
    <xsl:apply-templates match="entity"/>

    <xsl:text>}&#xA;</xsl:text>
  </xsl:template>
<!--
  Define a template to match each 'entity' (or Kind, Domain, Country) combination in the XML file.
-->
  <xsl:template match="siso:entity">
    <xsl:text>  namespace </xsl:text>
    <xsl:value-of select="concat(@kind, '_', @domain, '_', @country)"/>
<!--     <xsl:variable name="kindNum" select="@kind" />
 -->    
    <xsl:text> {&#xA;</xsl:text>
    <xsl:call-templates match="category">
      <xsl:with-param name="kindNum" select="@kind"/>
    </xsl:call-templates>
    <xsl:text>  }&#xA;</xsl:text>
  </xsl:template>

<!--
  Define a template to match each 'category' in the XML file.
-->
  <xsl:template match="siso:category">
    <xsl:param name="kindNum"/>
    <xsl:text>    namespace </xsl:text>
    <xsl:text>    Kind = </xsl:text>
    <xsl:value-of select="$kindNum" />
    <xsl:value-of select="@description"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates match="subcategory"/>

    <xsl:text>    }&#xA;</xsl:text>
  </xsl:template>
<!--
  Define a template to match each 'subcategory' in the XML file.
-->
  <xsl:template match="siso:subcategory">
    <xsl:text>      namespace </xsl:text>
    <xsl:value-of select="@description"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:text>      List Entity Type ENUMS &#xA;</xsl:text>
    <xsl:apply-templates match="specific"/>

    <xsl:text>      }&#xA;</xsl:text>
  </xsl:template>
<!--
  Define a template to match each 'specific' in the XML file.
-->
  <xsl:template match="siso:specific">
    <xsl:text>        namespace </xsl:text>
    <xsl:value-of select="@description"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:text>        List Entity Type ENUMS &#xA;</xsl:text>
    <xsl:apply-templates match="extra"/>

    <xsl:text>        }&#xA;</xsl:text>
  </xsl:template>
<!--
  Define a template to match each 'extra' in the XML file.
-->
  <xsl:template match="siso:extra">
    <xsl:text>          namespace </xsl:text>
    <xsl:value-of select="@description"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:text>          List Entity Type ENUMS &#xA;</xsl:text>

    <xsl:text>          }&#xA;</xsl:text>
  </xsl:template>

<!--
  Define a template to match each enum element in the XML file.
-->
  <xsl:template match="siso:enum">
    <xsl:text>enum </xsl:text>
    <xsl:value-of select="translate(@name, ' !&quot;#$%&amp;()*+,-./:;&lt;=&gt;?@[\]^`abcdefghijklmnopqrstuvwxyz{|}~', 
        '___________________________ABCDEFGHIJKLMNOPQRSTUVWXYZ____')"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates match="enumrow"/>
    <xsl:text>};&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
<!--
  Define a template to match each enum/enumrow element in the XML file.
-->
  <xsl:template match="siso:enumrow">
    <xsl:text>    </xsl:text>
    <!-- Define a variable to store the capitalized name with all special characters removed, except apostrophes. -->
    <xsl:variable name="cleaned_name" select="translate(@description, ' !&quot;#$%&amp;()*+,-./:;&lt;=&gt;?@[\]^`abcdefghijklmnopqrstuvwxyz{|}~', 
        '___________________________ABCDEFGHIJKLMNOPQRSTUVWXYZ____')"/>
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
