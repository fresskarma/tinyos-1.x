/*
 * Copyright (c) 2003, Vanderbilt University
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
 * UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 */

package isis.nest.messageCenter;

import net.tinyos.util.*;
import net.tinyos.message.*;


/**
 *
 * @author  nadand
 */
public class AllMSGDisplay extends MessageCenterInternalFrame implements PacketListenerIF {
    
    protected java.text.SimpleDateFormat timestamp = null;
    
    /** Creates new form AllMSGDisplay */
    public AllMSGDisplay() {
        super("Message Display");
        initComponents();
        SerialConnector.instance().registerPacketListener(this,SerialConnector.GET_ALL_MESSAGES);
        
        
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    private void initComponents() {//GEN-BEGIN:initComponents
        jScrollPane1 = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        subPanel = new javax.swing.JPanel();
        timestampCheckBox = new javax.swing.JCheckBox();
        jButton1 = new javax.swing.JButton();

        setTitle("Message Display");
        jScrollPane1.setPreferredSize(new java.awt.Dimension(320, 240));
        jScrollPane1.setViewportView(jTextArea1);

        getContentPane().add(jScrollPane1, java.awt.BorderLayout.CENTER);

        timestampCheckBox.setText("print timestamp");
        timestampCheckBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                timestampCheckBoxItemStateChanged(evt);
            }
        });

        subPanel.add(timestampCheckBox);

        jButton1.setText("Clear");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        subPanel.add(jButton1);

        getContentPane().add(subPanel, java.awt.BorderLayout.SOUTH);

        pack();
    }//GEN-END:initComponents

	private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
		jTextArea1.setText("");
	}//GEN-LAST:event_jButton1ActionPerformed

    private void timestampCheckBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_timestampCheckBoxItemStateChanged
    if (evt.getStateChange() == java.awt.event.ItemEvent.SELECTED) {
        this.timestamp = new java.text.SimpleDateFormat("HH:mm:ss.SSSS");
    } else if(evt.getStateChange() == java.awt.event.ItemEvent.DESELECTED) { 
        this.timestamp = null;
    }
    }//GEN-LAST:event_timestampCheckBoxItemStateChanged
    
    
    protected String getTimeStamp() {
        if( timestamp != null)
            return timestamp.format(new java.util.Date()) + ' ';
        
        return "";
    }
    /**  .
     */
    public void packetReceived(byte[] packet) {
        
        int type = packet[2] & 0xFF;
        int len = packet[4] & 0xFF;
        
        this.jTextArea1.append(getTimeStamp());
        
        // note that addr is always 0x7e (UART) and group is the current group
        this.jTextArea1.append("type=" + type);
        this.jTextArea1.append(" length=" + len);
        
        // first 5 bytes + 2 bytes for CRC
        if( len > packet.length - 7 )
            len = packet.length - 7;
        
        this.jTextArea1.append(" data:");
        for(int i = 0; i < len; ++i) {
            int data = packet[5+i] & 0xFF;
            this.jTextArea1.append(" " + data);
        }
        
        this.jTextArea1.append("\n");
        
    }
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JButton jButton1;
    private javax.swing.JPanel subPanel;
    private javax.swing.JCheckBox timestampCheckBox;
    private javax.swing.JTextArea jTextArea1;
    // End of variables declaration//GEN-END:variables
    
}
