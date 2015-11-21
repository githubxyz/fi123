package com.ims.ui.startup;

import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ims.dto.StockAlertDTO;
import com.ims.service.stockAlartService.IStockAlartService;
import com.ims.service.stockAlartService.StockAlartServicesImpl;
import com.ims.utility.Messages;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;

public class EmailJob implements Job{
	String username="insonera@gmail.com";
    String password="!@12QWqw";
    String host="smtp.gmail.com";
    Integer port=25;
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		try{
		IStockAlartService stockAlartService=new StockAlartServicesImpl();
		List<StockAlertDTO> alertDTOs=stockAlartService.listStockAlart();
		String message ="Please check the stock for for the below items <br>";
		for(Iterator it=alertDTOs.iterator();it.hasNext();){
			StockAlertDTO stockAlertDTO=(StockAlertDTO) it.next();
			message+="<font color='red'>"+stockAlertDTO.getProductMaster().getProductName()+
					"("+stockAlertDTO.getProductMaster().getProductCode()
					+")"+"</font><br>";
		}
		List recipients=new ArrayList<String>();
		recipients.add(Messages.getString("first_email"));
		recipients.add(Messages.getString("last_email"));
		if(alertDTOs!=null && alertDTOs.size()>0)
		sendMessage(recipients, "Low Stock alert", message);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public void sendMessage(List<String> recipients, String subject, String msg)
            throws MessagingException {
        //get the cc adress from messages
        //String ccAddres=Messages.getString("cc");
        Properties props = new Properties();
        // configure server connection
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", "synergy@net4.in");
        props.put("mail.smtp.debug", "true");
        props.put("mail.smtp.port", new Integer(25));
        props.put("mail.smtp.auth", "false");
       java.security.Security
                .addProvider(new com.sun.net.ssl.internal.ssl.Provider());
         props.put("mail.smtp.debug", "true");
        props.put("mail.smtp.socketFactory.port", new Integer(25));
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "true");
        props.setProperty("mail.smtp.socketFactory.port", Integer
                .toString(465));

        // Get session
        Authenticator auth = new SMTPAuthenticator();
        Session session = Session.getInstance(props, auth);
        Transport transport = session.getTransport("smtp");
        transport.connect(host, port, "asd", "asdasd");
        // Define message
        MimeMessage message = new MimeMessage(session);
        // set Address
       // message.setFrom(new InternetAddress("yy@jj.com"));
        InternetAddress[] toAddresses=new InternetAddress[2];
        toAddresses[0]=new InternetAddress(recipients.get(0));
        toAddresses[1]=new InternetAddress(recipients.get(1));
        message.addRecipients(Message.RecipientType.TO, toAddresses);
       // Address ccAddress = new InternetAddress(ccAddres);
       // message.addRecipient(Message.RecipientType.BCC, ccAddress);


        message.setSubject(subject);
        message.setContent(msg, "text/html");

        // Send message
        //Transport.send(message);

        transport.sendMessage(message, toAddresses);
        transport.close();
    }
    private class SMTPAuthenticator extends Authenticator {
        public javax.mail.PasswordAuthentication getPasswordAuthentication() {
            return new javax.mail.PasswordAuthentication(username, password);

        }
    }


}
