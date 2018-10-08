:: Script to run XSLT via Saxon processor.

:: Add the Saxon JAR file to the class path.
set CLASSPATH=D:\apps\SaxonHE9-9-0-1Java\saxon9he.jar

:: Call the Saxon XSLT processor to transform the XML file.
java net.sf.saxon.Transform -s:SISO-REF-010.xml -xsl:SISO-REF-010-cpp.xsl -o:SisoEnum.h


