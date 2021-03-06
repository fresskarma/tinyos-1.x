/*
 * SerialConnector2.java
 *
 * Created on September 13, 2005, 12:38 PM
 */

package net.tinyos.mcenter;
 
import java.util.prefs.BackingStoreException;
import java.util.prefs.Preferences;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.comm.CommPortIdentifier;
import javax.comm.NoSuchPortException;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

import java.awt.event.ItemEvent;
import java.io.IOException;

import net.tinyos.message.MessageFactory;
import net.tinyos.message.TOSMsg;

import net.tinyos.packet.BuildSource;
import net.tinyos.packet.PacketListenerIF;
import net.tinyos.packet.PhoenixError;

/**
 *
 * @author  nadand
 */
public class SerialConnector extends javax.swing.JInternalFrame{
    
	public static final int GET_ALL_MESSAGES = -1;
	private static final long serialVersionUID = 1L;
	
	static private SerialConnector _instance = null;
	
	
	private Preferences prefs = null;
    private ItemRadioButton lastSelected;
    
    
    private net.tinyos.packet.PacketSource serialStub;
    private PhoenixSource packetSource;
    private MessageFactory messageFactory;
    private PacketReader packetReader;
    private Connection activeConnection = null;
    private ConnectionPanel activePanel = null;
    
    private TOSMsg refPacket = null;
    private UniversalInterpreter currentMsgInterprter = null;
    
    private int rxCount = 0;
    private int txCount = 0;
        
    private Object sendMutex = new Object();
    
    /*-************************* Singleton Pattern "constructor" **********************/
    /**
     * Returns the sinlgeton instance of the SerialConnector.
     * @return The insatnce of the SerialConnector
     */
    static public SerialConnector instance() {
        if(null == _instance) {
            _instance = new SerialConnector();
        }
        return _instance;
    }
    
    
    
	/** Creates new form SerialConnector */
    public SerialConnector() {
        initComponents();
        initBehaviour();
        
        prefs = Preferences.userNodeForPackage(this.getClass());
        prefs = prefs.node(prefs.absolutePath()+"/SerialConnector2");
        loadComboBox();
    }
    
    private void initBehaviour(){
    	buttonGroupConn.add(this.connectionRadioButtonCOM);
    	buttonGroupConn.add(this.connectionRadioButtonIP);
        buttonGroupConn.add(this.connectionRadioButtonTossim);
        buttonGroupConn.add(this.connectionRadioButtonTossimSerial);
        buttonGroupConn.add(this.connectionRadioButtonOther);
        setEnabledOther(false);
        setEnabledRemote(false);
        setEnabledSerial(false);
        setEnabledTossimRadio(false);
        setEnabledTossimSerial(false);
        this.connectionRadioButtonCOM.doClick();
        
    }
    
    private void loadComboBox() {
        connComboBox.removeAllItems();
        
        try{
            Preferences p = prefs.node(prefs.absolutePath() + "/config");
            String[] configNames = p.childrenNames();
            for(int i=0; i< configNames.length; i++){
            	
            	Connection conn = loadConnection(configNames[i]);
            	ConnectionPanel connPanel = new ConnectionPanel(conn);
            	connectionsScrollPanel.add(connPanel);
            	
            	connComboBox.addItem(connPanel);
            }
        }catch (java.util.prefs.BackingStoreException bse){
            System.err.println("Cannot Load Configurations:"+ bse.getMessage());
        }
    }
    
    private Connection loadConnection(String name){
        Preferences p = prefs.node(prefs.absolutePath() + "/config/" + name);
        String connString = p.get("param", "");
        if(connString.length() < 1){
        	return null;
        }
        Connection defConn = new Connection(name,connString);
        try{
        	Connection newConn = new SerialConnection(defConn);
        	return newConn;
        }catch(ClassCastException cce){}
        try{
        	Connection newConn = new RemoteConnection(defConn);
        	return newConn;
        }catch(ClassCastException cce){}
        
        try{
        	Connection newConn = new TossimSerialConnection(defConn);
        	return newConn;
        }catch(ClassCastException cce){}

        try{
        	Connection newConn = new TossimRadioConnection(defConn);
        	return newConn;
        }catch(ClassCastException cce){}
        
        return defConn;
    	
    }
    
    private boolean saveConnection(Connection connection){
    	try {
            
            Preferences p = prefs.node(prefs.absolutePath() + "/config/" + connection.getName());
            p.put("param", connection.getConnectionString());
                        
            prefs.flush();
        } catch(BackingStoreException e) {
        	System.err.println("could not write preferences\n");
        	return false;
        };
        return true;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        java.awt.GridBagConstraints gridBagConstraints;

        buttonGroupConn = new javax.swing.ButtonGroup();
        mainTabbedPane = new javax.swing.JTabbedPane();
        allConnectionsPanel = new javax.swing.JPanel();
        connectionsScrollPane = new javax.swing.JScrollPane();
        connectionsScrollPanel = new javax.swing.JPanel();
        configurationPanel = new javax.swing.JPanel();
        connManagePanel = new javax.swing.JPanel();
        connComboBox = new javax.swing.JComboBox();
        connSaveButton = new javax.swing.JButton();
        connRemoveButton = new javax.swing.JButton();
        jSeparator3 = new javax.swing.JSeparator();
        connectionRadioButtonCOM = new ItemRadioButton();
        comPortLabel = new javax.swing.JLabel();
        comPortTextField = new javax.swing.JTextField();
        speedLabel = new javax.swing.JLabel();
        comSpeedTextField = new javax.swing.JTextField();
        placeholder2 = new javax.swing.JLabel();
        oldProtocolCheckBox = new javax.swing.JCheckBox();
        placeholder3 = new javax.swing.JLabel();
        packetSizeLabel = new javax.swing.JLabel();
        packetSizeTextField = new javax.swing.JTextField();
        placeholder4 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        connectionRadioButtonIP = new ItemRadioButton();
        ipLabel = new javax.swing.JLabel();
        ipAddressTextField = new javax.swing.JTextField();
        portLabel = new javax.swing.JLabel();
        ipPortTextField = new javax.swing.JTextField();
        jSeparator4 = new javax.swing.JSeparator();
        connectionRadioButtonTossimSerial = new ItemRadioButton();
        tossimSerialLabel = new javax.swing.JLabel();
        tossimSerialAddressTextField = new javax.swing.JTextField();
        placeholder1 = new javax.swing.JLabel();
        jSeparator5 = new javax.swing.JSeparator();
        connectionRadioButtonTossim = new ItemRadioButton();
        tossimRadioLabel = new javax.swing.JLabel();
        tossimRadioAddressTextField = new javax.swing.JTextField();
        placeholder = new javax.swing.JLabel();
        jSeparator6 = new javax.swing.JSeparator();
        connectionRadioButtonOther = new ItemRadioButton();
        otherConnLabel = new javax.swing.JLabel();
        otherConnTextField = new javax.swing.JTextField();
        threadingCheckBox = new javax.swing.JCheckBox();
        jSeparator2 = new javax.swing.JSeparator();
        groupLabel = new javax.swing.JLabel();
        groupTextField = new javax.swing.JTextField();
        monitorPanel = new javax.swing.JPanel();
        rxLabel = new javax.swing.JLabel();
        rxTextField = new javax.swing.JTextField();
        txLabel = new javax.swing.JLabel();
        txTextField = new javax.swing.JTextField();
        graphPanel = new javax.swing.JPanel();

        setTitle("Serial Connector 2.0");
        allConnectionsPanel.setLayout(new java.awt.BorderLayout());

        connectionsScrollPanel.setLayout(new java.awt.GridLayout(0, 1));

        connectionsScrollPane.setViewportView(connectionsScrollPanel);

        allConnectionsPanel.add(connectionsScrollPane, java.awt.BorderLayout.CENTER);

        mainTabbedPane.addTab("Connections", allConnectionsPanel);

        configurationPanel.setLayout(new java.awt.GridBagLayout());

        configurationPanel.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
        connManagePanel.setLayout(new java.awt.GridBagLayout());

        connManagePanel.setBorder(new javax.swing.border.TitledBorder("Manage Connections"));
        connComboBox.setEditable(true);
        connComboBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connComboBoxActionPerformed(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connComboBox, gridBagConstraints);

        connSaveButton.setText("Save");
        connSaveButton.setMaximumSize(new java.awt.Dimension(75, 23));
        connSaveButton.setMinimumSize(new java.awt.Dimension(75, 23));
        connSaveButton.setPreferredSize(new java.awt.Dimension(75, 23));
        connSaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connSaveButtonActionPerformed(evt);
            }
        });

        connManagePanel.add(connSaveButton, new java.awt.GridBagConstraints());

        connRemoveButton.setText("Remove");
        connRemoveButton.setMaximumSize(new java.awt.Dimension(75, 23));
        connRemoveButton.setMinimumSize(new java.awt.Dimension(75, 23));
        connRemoveButton.setPreferredSize(new java.awt.Dimension(75, 23));
        connRemoveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connRemoveButtonActionPerformed(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        connManagePanel.add(connRemoveButton, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(jSeparator3, gridBagConstraints);

        connectionRadioButtonCOM.setText("Serial Port");
        connectionRadioButtonCOM.setMaximumSize(new java.awt.Dimension(32767, 32767));
        connectionRadioButtonCOM.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                connectionRadioButtonCOMItemStateChanged(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connectionRadioButtonCOM, gridBagConstraints);

        comPortLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        comPortLabel.setText("port");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(comPortLabel, gridBagConstraints);

        comPortTextField.setText("COM1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(comPortTextField, gridBagConstraints);

        speedLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        speedLabel.setText("speed");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(speedLabel, gridBagConstraints);

        comSpeedTextField.setText("57600");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(comSpeedTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        connManagePanel.add(placeholder2, gridBagConstraints);

        oldProtocolCheckBox.setText("Old Serial Protocol (No Framing)");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(oldProtocolCheckBox, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        connManagePanel.add(placeholder3, gridBagConstraints);

        packetSizeLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        packetSizeLabel.setText("packet size");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(packetSizeLabel, gridBagConstraints);

        packetSizeTextField.setText("36");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(packetSizeTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        connManagePanel.add(placeholder4, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(jSeparator1, gridBagConstraints);

        connectionRadioButtonIP.setText("Remote Server");
        connectionRadioButtonIP.setMaximumSize(new java.awt.Dimension(32767, 32767));
        connectionRadioButtonIP.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                connectionRadioButtonIPItemStateChanged(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connectionRadioButtonIP, gridBagConstraints);

        ipLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        ipLabel.setText("address");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        connManagePanel.add(ipLabel, gridBagConstraints);

        ipAddressTextField.setText("127.0.0.1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(ipAddressTextField, gridBagConstraints);

        portLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        portLabel.setText("port");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        connManagePanel.add(portLabel, gridBagConstraints);

        ipPortTextField.setText("9000");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(ipPortTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(jSeparator4, gridBagConstraints);

        connectionRadioButtonTossimSerial.setText("Tossim Serial");
        connectionRadioButtonTossimSerial.setMaximumSize(new java.awt.Dimension(32767, 32767));
        connectionRadioButtonTossimSerial.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                connectionRadioButtonTossimSerialItemStateChanged(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connectionRadioButtonTossimSerial, gridBagConstraints);

        tossimSerialLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        tossimSerialLabel.setText("address");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        connManagePanel.add(tossimSerialLabel, gridBagConstraints);

        tossimSerialAddressTextField.setText("127.0.0.1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        connManagePanel.add(tossimSerialAddressTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        connManagePanel.add(placeholder1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(jSeparator5, gridBagConstraints);

        connectionRadioButtonTossim.setText("Tossim Radio");
        connectionRadioButtonTossim.setMaximumSize(new java.awt.Dimension(32767, 32767));
        connectionRadioButtonTossim.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                connectionRadioButtonTossimItemStateChanged(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connectionRadioButtonTossim, gridBagConstraints);

        tossimRadioLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        tossimRadioLabel.setText("address");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        connManagePanel.add(tossimRadioLabel, gridBagConstraints);

        tossimRadioAddressTextField.setText("127.0.0.1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(tossimRadioAddressTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        connManagePanel.add(placeholder, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(jSeparator6, gridBagConstraints);

        connectionRadioButtonOther.setText("Other Connection");
        connectionRadioButtonOther.setMaximumSize(new java.awt.Dimension(32767, 32767));
        connectionRadioButtonOther.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                connectionRadioButtonOtherItemStateChanged(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        connManagePanel.add(connectionRadioButtonOther, gridBagConstraints);

        otherConnLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        otherConnLabel.setText("string");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        connManagePanel.add(otherConnLabel, gridBagConstraints);

        otherConnTextField.setText("127.0.0.1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        connManagePanel.add(otherConnTextField, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.weighty = 1.0;
        configurationPanel.add(connManagePanel, gridBagConstraints);

        threadingCheckBox.setText("Enable Threading");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        configurationPanel.add(threadingCheckBox, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        configurationPanel.add(jSeparator2, gridBagConstraints);

        groupLabel.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        groupLabel.setText("group ID");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 0.1;
        configurationPanel.add(groupLabel, gridBagConstraints);

        groupTextField.setEditable(false);
        groupTextField.setText("0x7D");
        groupTextField.setMinimumSize(new java.awt.Dimension(80, 20));
        groupTextField.setPreferredSize(new java.awt.Dimension(80, 20));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.weightx = 1.0;
        configurationPanel.add(groupTextField, gridBagConstraints);

        mainTabbedPane.addTab("Configuration", configurationPanel);

        getContentPane().add(mainTabbedPane, java.awt.BorderLayout.CENTER);

        monitorPanel.setLayout(new java.awt.GridBagLayout());

        monitorPanel.setBorder(new javax.swing.border.TitledBorder("Rx/Tx Monitor"));
        rxLabel.setText("Rx: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 2, 1, 0);
        monitorPanel.add(rxLabel, gridBagConstraints);

        rxTextField.setHorizontalAlignment(javax.swing.JTextField.TRAILING);
        rxTextField.setText("0");
        rxTextField.setMinimumSize(new java.awt.Dimension(50, 20));
        rxTextField.setPreferredSize(new java.awt.Dimension(50, 20));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.RELATIVE;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 1, 2);
        monitorPanel.add(rxTextField, gridBagConstraints);

        txLabel.setText("Tx: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.insets = new java.awt.Insets(1, 2, 2, 0);
        monitorPanel.add(txLabel, gridBagConstraints);

        txTextField.setHorizontalAlignment(javax.swing.JTextField.TRAILING);
        txTextField.setText("0");
        txTextField.setMinimumSize(new java.awt.Dimension(50, 20));
        txTextField.setPreferredSize(new java.awt.Dimension(50, 20));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.insets = new java.awt.Insets(1, 0, 2, 2);
        monitorPanel.add(txTextField, gridBagConstraints);

        graphPanel.setBackground(new java.awt.Color(0, 0, 0));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(0, 2, 2, 2);
        monitorPanel.add(graphPanel, gridBagConstraints);

        getContentPane().add(monitorPanel, java.awt.BorderLayout.SOUTH);

        pack();
    }
    // </editor-fold>//GEN-END:initComponents

    private void connectionRadioButtonOtherItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_connectionRadioButtonOtherItemStateChanged
        if (evt.getStateChange() == ItemEvent.SELECTED) {
        	setEnabledOther(true);
            lastSelected = (ItemRadioButton)connectionRadioButtonOther;
            
        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {
        	setEnabledOther(false);

            
        }
    }//GEN-LAST:event_connectionRadioButtonOtherItemStateChanged

    private void connectionRadioButtonTossimItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_connectionRadioButtonTossimItemStateChanged
        if (evt.getStateChange() == ItemEvent.SELECTED) {
        	setEnabledTossimRadio(true);
            lastSelected = (ItemRadioButton)connectionRadioButtonTossim;
            
        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {
        	setEnabledTossimRadio(false);
        }
    }//GEN-LAST:event_connectionRadioButtonTossimItemStateChanged

    private void connectionRadioButtonIPItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_connectionRadioButtonIPItemStateChanged
        if (evt.getStateChange() == ItemEvent.SELECTED) {
        	setEnabledRemote(true);
            lastSelected = (ItemRadioButton) connectionRadioButtonIP;
            
        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {
        	setEnabledRemote(false);
            
        }
    }//GEN-LAST:event_connectionRadioButtonIPItemStateChanged

    private void connectionRadioButtonTossimSerialItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_connectionRadioButtonTossimSerialItemStateChanged
        if (evt.getStateChange() == ItemEvent.SELECTED) {
        	setEnabledTossimSerial(true);
            lastSelected = (ItemRadioButton) connectionRadioButtonTossimSerial;
            
        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {
        	setEnabledTossimSerial(false);
        }
    }//GEN-LAST:event_connectionRadioButtonTossimSerialItemStateChanged

    private void connectionRadioButtonCOMItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_connectionRadioButtonCOMItemStateChanged
        if (evt.getStateChange() == ItemEvent.SELECTED) {
        	setEnabledSerial(true);
            lastSelected = (ItemRadioButton)connectionRadioButtonCOM;
            
        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {
        	setEnabledSerial(false);
            
            
            
        }
    }//GEN-LAST:event_connectionRadioButtonCOMItemStateChanged



    private void connComboBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connComboBoxActionPerformed
    	if( connComboBox.getSelectedIndex() < 0 ){
            return;
    	}
        ConnectionPanel connPanel = (ConnectionPanel)connComboBox.getSelectedItem();
        Connection selectedConn = connPanel.getConnection();

        if( selectedConn instanceof SerialConnection){
        	connectionRadioButtonCOM.doClick();
        	comPortTextField.setText( ((SerialConnection)selectedConn).getPort());
            comSpeedTextField.setText( ((SerialConnection)selectedConn).getSpeed());
            oldProtocolCheckBox.setSelected(((SerialConnection)selectedConn).isOldProtocol());
            
        }else if( selectedConn instanceof RemoteConnection){
        	connectionRadioButtonIP.doClick();
        	ipAddressTextField.setText( ((RemoteConnection)selectedConn).getAddress());
            ipPortTextField.setText( ((RemoteConnection)selectedConn).getPort());
        	
        }else if( selectedConn instanceof TossimSerialConnection){
        	connectionRadioButtonTossimSerial.doClick();
        	tossimSerialAddressTextField.setText( ((TossimSerialConnection)selectedConn).getAddress());
        	
        }else if( selectedConn instanceof TossimRadioConnection){
        	connectionRadioButtonTossim.doClick();
        	tossimRadioAddressTextField.setText( ((TossimRadioConnection)selectedConn).getAddress());
        }else{
        	connectionRadioButtonOther.doClick();
        	otherConnTextField.setText(selectedConn.getConnectionString());
        }

    }//GEN-LAST:event_connComboBoxActionPerformed

    private void connSaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connSaveButtonActionPerformed


    	Connection selectedConnection = null;
    	if(lastSelected == (ItemRadioButton)connectionRadioButtonCOM){
    		int packetSize = 80;
    		try{
                packetSize =(short)(Integer.parseInt(packetSizeTextField.getText()) & 0xff);
            }catch(Exception e){
            	System.err.println("Unable to parse packet size field: " + e.getMessage());
                return;
            } 
    		selectedConnection = new SerialConnection((String) connComboBox.getSelectedItem(),comPortTextField.getText().trim(),comSpeedTextField.getText().trim(),oldProtocolCheckBox.isSelected(),packetSize);
    	}else if(lastSelected == (ItemRadioButton)connectionRadioButtonIP){
    		selectedConnection = new RemoteConnection((String) connComboBox.getSelectedItem(),ipAddressTextField.getText().trim(),ipPortTextField.getText().trim());
    	}else if(lastSelected == (ItemRadioButton)connectionRadioButtonTossimSerial){
    		selectedConnection = new TossimSerialConnection((String) connComboBox.getSelectedItem(),tossimSerialAddressTextField.getText().trim());
    	}else if(lastSelected == (ItemRadioButton)connectionRadioButtonTossim){
    		selectedConnection = new TossimRadioConnection((String) connComboBox.getSelectedItem(),tossimRadioAddressTextField.getText().trim());
    	}else{
    		selectedConnection = new Connection((String) connComboBox.getSelectedItem(),otherConnTextField.getText().trim());
    	}
        if( connComboBox.getSelectedIndex() < 0 ){
        	ConnectionPanel connPanel = new ConnectionPanel(selectedConnection);
        	connComboBox.addItem(connPanel);
        	connectionsScrollPanel.add(connPanel);
        	
        }else{
        	ConnectionPanel selectedPanel = (ConnectionPanel)connComboBox.getSelectedItem();
        	selectedPanel.setConnection(selectedConnection);
        }
        
        saveConnection(selectedConnection);
        System.out.println("connection " + selectedConnection.getName() + " saved\n");
    }//GEN-LAST:event_connSaveButtonActionPerformed

    private void connRemoveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connRemoveButtonActionPerformed
    	if( connComboBox.getSelectedIndex() < 0 )
            return;
        ConnectionPanel connPanel = (ConnectionPanel)connComboBox.getSelectedItem();
        if(connPanel.startStopButton.isSelected()){
        	System.out.println("Cannot remove active connection!!!");
        	return;
        }
        	
    	String name = connPanel.getConnection().getName();
       
        try {
            Preferences p = prefs.node(prefs.absolutePath() + "/config/" + name);
            p.removeNode();
            prefs.flush();

            connComboBox.removeItem(connPanel);
            connectionsScrollPanel.remove(connPanel);
            
            
            System.out.println("configuration " + name + " removed\n");
            
        } catch(BackingStoreException e) {
        	System.err.println("could not write preferences\n");
            
        };
    }//GEN-LAST:event_connRemoveButtonActionPerformed
    
    private void setEnabledSerial(boolean enabled){
    	this.comPortTextField.setEnabled(enabled);
        this.comSpeedTextField.setEnabled(enabled);
        this.comPortLabel.setEnabled(enabled);
        this.speedLabel.setEnabled(enabled);
        this.oldProtocolCheckBox.setEnabled(enabled);  
        this.packetSizeLabel.setEnabled(enabled);
        this.packetSizeTextField.setEnabled(enabled);
    }
    
    private void setEnabledRemote(boolean enabled){
    	this.ipLabel.setEnabled(enabled);
        this.ipAddressTextField.setEnabled(enabled);
        this.ipPortTextField.setEnabled(enabled);
        this.portLabel.setEnabled(enabled);
    }
    
    private void setEnabledTossimSerial(boolean enabled){
        this.tossimSerialLabel.setEnabled(enabled);
        this.tossimSerialAddressTextField.setEnabled(enabled);

    }
    
    private void setEnabledTossimRadio(boolean enabled){
        this.tossimRadioLabel.setEnabled(enabled);
        this.tossimRadioAddressTextField.setEnabled(enabled);

    }
    
    private void setEnabledOther(boolean enabled){
        this.otherConnLabel.setEnabled(enabled);
        this.otherConnTextField.setEnabled(enabled);
    }
    
    private boolean startConnection(Connection connection){
    	if(packetSource != null){
    		System.out.println("Already connected to another port!");
    		return false;
    	}
    	System.out.println("Connecting to: " + connection.getConnectionString());
    	    	    	
    	try{
    		connection.validate();
    		activeConnection = connection;
    			
	    	serialStub = BuildSource.makePacketSource(connection.getConnectionString());
	    	packetReader = new PacketReader();
	    	packetSource = new PhoenixSource(serialStub,null);
	        packetSource.registerPacketListener(packetReader);
	        ((PhoenixSource)packetSource).setPacketErrorHandler( new PhoenixError(){
		        
		        public void error(IOException e) {
			    	System.err.println(" packet source error - shuting down (" + e + ")");
			    	stopConnection(activeConnection);
			    	if(activePanel != null)
			    		activePanel.startStopButton.setSelected(false);
			    	
		        }
		    });
	        
	        
	        
	        
	        packetSource.start();
	        packetSource.awaitStartup();
	        
	        
	    	messageFactory = new MessageFactory(serialStub);
	    	refPacket = messageFactory.createTOSMsg();
	    	byte[] msgData = refPacket.dataGet();
	    	for(int i = 0; i < msgData.length ; i++)
	    		msgData[i] = (byte)i;
	    	currentMsgInterprter = new UniversalInterpreter(refPacket);
    	}catch(IOException ioe){
    		System.err.println("Could not connect to port: " + ioe.toString());
    		return false;
    	}
        System.out.println("Connected.");
    	return true;
    }
    
    private boolean stopConnection(Connection connection){
    	if(packetSource == null)
    		return true;
    	
    	packetSource.shutdown();
    	packetSource = null;
    	serialStub = null;
        refPacket = null;
        packetReader = null;
        currentMsgInterprter = null;
        activeConnection = null;
        System.out.println("Connection closed.");
    	return true;
    }
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel allConnectionsPanel;
    private javax.swing.ButtonGroup buttonGroupConn;
    private javax.swing.JLabel comPortLabel;
    private javax.swing.JTextField comPortTextField;
    private javax.swing.JTextField comSpeedTextField;
    private javax.swing.JPanel configurationPanel;
    private javax.swing.JComboBox connComboBox;
    private javax.swing.JPanel connManagePanel;
    private javax.swing.JButton connRemoveButton;
    private javax.swing.JButton connSaveButton;
    private javax.swing.JRadioButton connectionRadioButtonCOM;
    private javax.swing.JRadioButton connectionRadioButtonIP;
    private javax.swing.JRadioButton connectionRadioButtonOther;
    private javax.swing.JRadioButton connectionRadioButtonTossim;
    private javax.swing.JRadioButton connectionRadioButtonTossimSerial;
    private javax.swing.JScrollPane connectionsScrollPane;
    private javax.swing.JPanel connectionsScrollPanel;
    private javax.swing.JPanel graphPanel;
    private javax.swing.JLabel groupLabel;
    private javax.swing.JTextField groupTextField;
    private javax.swing.JTextField ipAddressTextField;
    private javax.swing.JLabel ipLabel;
    private javax.swing.JTextField ipPortTextField;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JSeparator jSeparator3;
    private javax.swing.JSeparator jSeparator4;
    private javax.swing.JSeparator jSeparator5;
    private javax.swing.JSeparator jSeparator6;
    private javax.swing.JTabbedPane mainTabbedPane;
    private javax.swing.JPanel monitorPanel;
    private javax.swing.JCheckBox oldProtocolCheckBox;
    private javax.swing.JLabel otherConnLabel;
    private javax.swing.JTextField otherConnTextField;
    private javax.swing.JLabel packetSizeLabel;
    private javax.swing.JTextField packetSizeTextField;
    private javax.swing.JLabel placeholder;
    private javax.swing.JLabel placeholder1;
    private javax.swing.JLabel placeholder2;
    private javax.swing.JLabel placeholder3;
    private javax.swing.JLabel placeholder4;
    private javax.swing.JLabel portLabel;
    private javax.swing.JLabel rxLabel;
    private javax.swing.JTextField rxTextField;
    private javax.swing.JLabel speedLabel;
    private javax.swing.JCheckBox threadingCheckBox;
    private javax.swing.JTextField tossimRadioAddressTextField;
    private javax.swing.JLabel tossimRadioLabel;
    private javax.swing.JTextField tossimSerialAddressTextField;
    private javax.swing.JLabel tossimSerialLabel;
    private javax.swing.JLabel txLabel;
    private javax.swing.JTextField txTextField;
    // End of variables declaration//GEN-END:variables
    
/*-********************************Message sendIF******************************/
    
    
    private java.util.HashMap messageIdRegisterMap = new java.util.HashMap();
    
    public MessageInterpreter getMessageInterprter(){
    	return currentMsgInterprter;
    }
    
    /**
     * Registers an Object implemneting the PacketListenerIF to receive the messages.
     * @param packetListener The Object implemneting the PacketListenerIF to receive messages.
     * @param messageID The type of the messages to receive.
     */
    public synchronized void registerPacketListener(PacketListenerIF packetListener, int messageID){
        java.util.HashSet listenerList;
        if(messageIdRegisterMap.containsKey(new Integer(messageID))) {
            listenerList = (java.util.HashSet) this.messageIdRegisterMap.get(new Integer(messageID));
        }else {
            listenerList = new java.util.HashSet();
            this.messageIdRegisterMap.put(new Integer(messageID),listenerList);
        }
        
        listenerList.add(packetListener);
        
    }
    
    /**
     * Removes an Object implemneting the PacketListenerIF to not receive messages of certain type.
     * @param packetListener The Object implemneting the PacketListenerIF to be removed form message receiving.
     * @param messageID Th type of the messages that the packetListener should not receive.
     */
    public synchronized boolean removePacketListener(PacketListenerIF packetListener, int messageID){
        java.util.HashSet listenerList;
        if(messageIdRegisterMap.containsKey(new Integer(messageID))) {
            listenerList = (java.util.HashSet) this.messageIdRegisterMap.get(new Integer(messageID));
        }else {
            return false;
        }
        
        if(listenerList.remove(packetListener)){
            if(listenerList.isEmpty())
                messageIdRegisterMap.remove(new Integer(messageID));
            return true;
        }
        return false;
    }
    
    /**
     * Removes an Object implemneting the PacketListenerIF to not receive any message.
     * @param packetListener The Object implemneting the PacketListenerIF to be removed form message receiving.
     */
    public synchronized boolean removePacketListener(MessageCenterInternalFrame packetListener){
        java.util.HashSet listenerList;
        java.util.Iterator mapIt = messageIdRegisterMap.keySet().iterator();
        while(mapIt.hasNext()){
            Object key = mapIt.next();
            if(messageIdRegisterMap.containsKey(key)) {
                listenerList = (java.util.HashSet) this.messageIdRegisterMap.get(key);
            }else {
                continue;
            }
            
            if(listenerList.remove(packetListener)){
                if(listenerList.isEmpty())
                    mapIt.remove();
                
            }
            
        }
        return true;
    }
    
    /**
     * Sends a message through the selected communication channel to the Mote network
     * @param address The address of the mote to receive the message
     * @param type The type of the message
     * @param data Array with the payload of the message. 
     * @return True if the message has been sent, false otherwise
     */
    public boolean sendMessage(int address, short type, byte[] data){
                
        if(refPacket != null){
	        TOSMsg tosPacket = messageFactory.createTOSMsg(data.length+refPacket.offset_data(0));
	        //address
	        tosPacket.set_addr(address);
	        //type
	        tosPacket.set_type(type);
	        //Group -- it is set by the TOSBase
	        tosPacket.set_group((short)0xFF);
	        //Length
	        tosPacket.set_length((short)data.length);
	        //data
	        tosPacket.set_data(data);
	        
	        try{
	        	synchronized(sendMutex){
	        		
	        		if(!serialStub.writePacket(tosPacket.dataGet())){
	        			return false;
	        		}
	        		txTextField.setText(Long.toString(++txCount));
	        	}
	            return true;
	
	        }catch(java.io.IOException ioe){
	        	System.err.println("I/O Exception while sending message:"+ ioe.getMessage());
	            	            
	        }catch(java.lang.NullPointerException npe){
	            System.err.println("Cannot send message! Port not connected!");
	        }
		}else{
			System.err.println("Cannot send message! Port not connected!");
		}
        return false;
        
    }
    
    /*-*****************************Inner Classes***********************************/
    private class ItemRadioButton extends javax.swing.JRadioButton{
        
		private static final long serialVersionUID = 1L;

		public ItemRadioButton(){
        }
        
        public void changeEnabledState(java.awt.event.ItemEvent itemEvent){
            this.fireItemStateChanged(itemEvent);
        }
    }
    
    private class Connection {
    	
    	private String name = "";
    	private String connectionString = "";
    	
    	   	
    	public Connection(String name, String connectionString)  throws ClassCastException{
			super();

			this.connectionString = connectionString;
			this.name = name;
		}
	
    	
		public String getConnectionString() {
			return connectionString;
		}
		public String getName() {
			return name;
		}
    	
		public String toString(){
			return getConnectionString();
		}
    	
		public void validate() throws IOException{
			
		}
		
    }
    
    private class SerialConnection extends Connection{
    	
    	private static final String prefix = "serial@";
    	private static final String oldprefix = "old-serial@";
    	private static final String dataFormat = "(COM\\d+):(\\w+)";
    	private static final String oldDataFormat = "(COM\\d+):(\\w+),(\\d+)";
    	private Pattern pattern = null;
    	private Pattern oldPattern = null;
    	private Matcher matcher = null;
    	private Matcher oldMatcher = null;
    	
    	
    	public SerialConnection(Connection connection) throws ClassCastException {
			super(connection.name, connection.connectionString);
			pattern = Pattern.compile(prefix+dataFormat);
			oldPattern = Pattern.compile(oldprefix+oldDataFormat);
			matcher = pattern.matcher(connection.connectionString);
			oldMatcher = oldPattern.matcher(connection.connectionString);
			if(!matcher.matches() && ! oldMatcher.matches())
				throw new ClassCastException("Cannot parse connection string!");
			
		}
    	
    	public SerialConnection(String name, String port, String speed, boolean oldProtocol){
    			this(name,port,speed,oldProtocol,80);
    	}
    	
    	public SerialConnection(String name, String port, String speed, boolean oldProtocol, int packetLength){
			super(name,"");
			if (oldProtocol)
				super.connectionString = oldprefix + port + ":" + speed + "," + packetLength;
			else
				super.connectionString = prefix + port + ":" + speed;
			
			this.pattern = Pattern.compile(prefix+dataFormat);
			oldPattern = Pattern.compile(oldprefix+oldDataFormat);
			this.matcher = pattern.matcher(super.connectionString);
			oldMatcher = oldPattern.matcher(super.connectionString);
			matcher.matches();
			oldMatcher.matches();
	}
    	
		public boolean isOldProtocol() {
			return oldMatcher.matches();
		}

		public String getPort() {
			Matcher m = (oldMatcher.matches())? oldMatcher : matcher; 
			return m.group(1);
		}

		public String getSpeed() {
			Matcher m = (oldMatcher.matches())? oldMatcher : matcher; 
			return m.group(2);
		}
    	
		public void validate() throws IOException{
			try{
				CommPortIdentifier commPort = CommPortIdentifier.getPortIdentifier(getPort());
				if( commPort.isCurrentlyOwned() )
					throw new IOException("The port " +getPort() + " is in use!");
			}catch(NoSuchPortException nspe){
				throw new IOException("The port " +getPort() + " does not exist!");
			}
		}	
		
    	
    }
    
    private class RemoteConnection extends Connection{
    	
    	private static final String prefix = "sf@";
    	private static final String dataFormat = "((\\d+.\\d+.\\d+.\\d+)|\\w+):(\\d+)";
    	
    	private Pattern pattern = null; 
    	private Matcher matcher = null;
    	
		public RemoteConnection(Connection connection) throws ClassCastException {
			super(connection.name, connection.connectionString);
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(super.connectionString);
			if(!matcher.matches())
				throw new ClassCastException("Cannot parse connection string!");
		}
		
		public RemoteConnection (String name, String address, String port){
			super(name,prefix + address+":"+port);
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(super.connectionString);
			matcher.matches();
    	}
		
		public String getAddress() {
			return matcher.group(1);
		}
		
		public String getPort() {
			return matcher.group(3);
		}
    }
    
    private class TossimSerialConnection extends Connection{
    	
    	private static final String prefix = "tossim-serial@";
    	private static final String dataFormat = "((\\d+.\\d+.\\d+.\\d+)|\\w+)";

    	private Pattern pattern = null; 
    	private Matcher matcher = null;
    	
    	public TossimSerialConnection(Connection connection) throws ClassCastException {
			super(connection.name, connection.connectionString);
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(connection.connectionString);
			if(!matcher.matches())
				throw new ClassCastException("Cannot parse connection string!");
		}
    	
    	public TossimSerialConnection(String name, String address){
    		super(name,prefix+address);
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(super.connectionString);
			matcher.matches();
    	}
    	
    	public String getAddress() {
			return matcher.group(1);
		}
    }
    
    private class TossimRadioConnection extends Connection{

    	private static final String prefix = "tossim-radio@";
    	private static final String dataFormat = "((\\d+.\\d+.\\d+.\\d+)|\\w+)";

    	private Pattern pattern = null; 
    	private Matcher matcher = null;
    	
		public TossimRadioConnection(Connection connection) throws ClassCastException {
			super(connection.name, connection.connectionString);
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(connection.connectionString);
			if(!matcher.matches())
				throw new ClassCastException("Cannot parse connection string!");
		}
    	
		public TossimRadioConnection(String name, String address){
    		super(name,"");
			super.connectionString = prefix+address;
			pattern = Pattern.compile(prefix+dataFormat);
			matcher = pattern.matcher(super.connectionString);
			matcher.matches();
    	}
		
		public String getAddress() {
			return matcher.group(1);
		}
    }
    
    private class ConnectionPanel extends JPanel{

		private static final long serialVersionUID = 1L;
		
		private Connection connection = null;

		private javax.swing.JToggleButton startStopButton;
	    private javax.swing.JTextField statusTextField;
	    private javax.swing.JTextField connectionSpecTextField;
		
		public ConnectionPanel(Connection connection) {
						
			this.connection = connection;
			initPanel(this);
		} 
    	
		private void initPanel(JPanel connPanel){
			startStopButton = new javax.swing.JToggleButton();
		    statusTextField = new javax.swing.JTextField();
		    connectionSpecTextField = new javax.swing.JTextField();
		    
			java.awt.GridBagConstraints gridBagConstraints;
			connPanel.setLayout(new java.awt.GridBagLayout());

	        connPanel.setBorder(new javax.swing.border.TitledBorder(connection.getName()));
	        connectionSpecTextField.setEditable(false);
	        connectionSpecTextField.setText(connection.getConnectionString());
	        connectionSpecTextField.setToolTipText("The connection configuration string");
	        gridBagConstraints = new java.awt.GridBagConstraints();
	        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
	        gridBagConstraints.weightx = 1.0;
	        gridBagConstraints.insets = new java.awt.Insets(0, 2, 2, 1);
	        connPanel.add(connectionSpecTextField, gridBagConstraints);

	        statusTextField.setEditable(false);
	        statusTextField.setText("inactive");
	        statusTextField.setToolTipText("The state of the connection");
	        statusTextField.setMaximumSize(new java.awt.Dimension(55, 20));
	        statusTextField.setMinimumSize(new java.awt.Dimension(55, 20));
	        statusTextField.setPreferredSize(new java.awt.Dimension(55, 20));
	        gridBagConstraints = new java.awt.GridBagConstraints();
	        gridBagConstraints.insets = new java.awt.Insets(0, 1, 2, 1);
	        connPanel.add(statusTextField, gridBagConstraints);

	        startStopButton.setText("Start");
	        startStopButton.setMaximumSize(new java.awt.Dimension(65, 25));
	        startStopButton.setMinimumSize(new java.awt.Dimension(65, 25));
	        startStopButton.setPreferredSize(new java.awt.Dimension(65, 25));
	        startStopButton.addItemListener(new java.awt.event.ItemListener() {
	        	public void itemStateChanged(java.awt.event.ItemEvent evt) {
	                startStopButtonItemStateChanged(evt);
	            }
	        });
	        startStopButton.addActionListener(new java.awt.event.ActionListener() {
	            public void actionPerformed(java.awt.event.ActionEvent evt) {
	            	startStopButtonActionPerformed(evt);
	            }
	        });
	        
	        
	        gridBagConstraints = new java.awt.GridBagConstraints();
	        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
	        gridBagConstraints.insets = new java.awt.Insets(0, 1, 2, 2);
	        connPanel.add(startStopButton, gridBagConstraints);
		}
	    
		private void startStopButtonItemStateChanged(java.awt.event.ItemEvent evt) {
			
			if (evt.getStateChange() == ItemEvent.SELECTED) {
					startStopButton.setText("Stop");
					statusTextField.setText("active");
					activePanel = this;
	        } else if(evt.getStateChange() == ItemEvent.DESELECTED) {

	        		startStopButton.setText("Start");
	        		statusTextField.setText("inactive");
	        		activePanel = null;
	        }
			

	    }
		
		private void startStopButtonActionPerformed(java.awt.event.ActionEvent evt) {
			
			if(startStopButton.isSelected()){
				if(!startConnection(this.connection)){
					startStopButton.setSelected(false);
				}	
			}else{
				if(!stopConnection(this.connection)){
					startStopButton.setSelected(true);
				}	
				
			}
        	
		}
		
		public String toString(){
			return connection.getName();
		}
		
		public void setConnection(Connection connection){
			this.connection = connection;
			this.setBorder(new javax.swing.border.TitledBorder(connection.getName()));
			this.connectionSpecTextField.setText(connection.getConnectionString());
		}
		
		public Connection getConnection(){
			return connection;
		}
    }
    
    private class GuiPacketUpdater implements Runnable{
    	private int groupId;
    	
		public GuiPacketUpdater(int id) {
			groupId = id;
		}

		public void run() {
			rxTextField.setText(Long.toString(++rxCount));
			groupTextField.setText("0x" + Integer.toHexString(groupId));
			
		}
    	
    }
    
    protected class PacketReader extends Thread implements PacketListenerIF{
        boolean run = true;
        byte[] buffer = null;
        
        public PacketReader(){
        	setName("Packet Reader");
        }
        
        
        public void run(){
            try{
                while(run){
                    buffer = serialStub.readPacket();
                    packetReceived(buffer);
                }
            }catch(Exception e){
            }
        }
        
        public void stopRun(){
            run = false;
        }
        
        public void packetReceived(byte[] packet) {
           
            SwingUtilities.invokeLater(new GuiPacketUpdater(currentMsgInterprter.getGroup(packet)));
             
            java.util.HashSet toNotify = new java.util.HashSet();
            
            if(messageIdRegisterMap.containsKey(new Integer(GET_ALL_MESSAGES))) {
                toNotify.addAll((java.util.HashSet)messageIdRegisterMap.get(new Integer(GET_ALL_MESSAGES)));
            }
            if(messageIdRegisterMap.containsKey(new Integer(currentMsgInterprter.getType(packet)))) {
                toNotify.addAll((java.util.HashSet)messageIdRegisterMap.get(new Integer(currentMsgInterprter.getType(packet))));
            }
            java.util.Iterator notifyListIterator = toNotify.iterator();
            while(notifyListIterator.hasNext()){
                ((PacketListenerIF)notifyListIterator.next()).packetReceived(packet);
                
            }
            
        }
        
    }
}
