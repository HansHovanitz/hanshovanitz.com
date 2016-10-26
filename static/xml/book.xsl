<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foo="http://www.foo.org/" xmlns:bar="http://www.bar.org">
  <xsl:template match="/">
    <html>
      <body>
        <h2>My Book Collection</h2>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th>cover</th>
            <th>Isbn</th>
            <th>Title</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone</th>
            <th>Office</th>
            <th>Publisher</th>
            <th>Year</th>
            <th>Edition</th>
          </tr>
          <xsl:for-each select="Books/Book">

            <tr>
              <td>
                <xsl:value-of select="@Cover"/>
              </td>

              <td>
                <xsl:value-of select="Isbn"/>
              </td>
              <td>
                <xsl:value-of select="Title"/>
              </td>
              <td>
                <xsl:value-of select="Author/Name/First"/>
              </td>
              <td>
                <xsl:value-of select="Author/Name/Last"/>
              </td>
              <td >
                <xsl:value-of select="Author/Contact/Phone"/>
              </td>
              <td>
                <xsl:value-of select="Author/Contact/Phone/@Office"/>

              </td>
              <td>
                <xsl:value-of select="Publisher"/>
              </td>
              <td>
                <xsl:value-of select="Year"/>
              </td>
              <td>
                <xsl:value-of select="Year/@Edition"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>