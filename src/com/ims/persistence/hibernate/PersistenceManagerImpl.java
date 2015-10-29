package com.ims.persistence.hibernate;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.StaleObjectStateException;
import org.hibernate.exception.ConstraintViolationException;

import com.ims.exception.IPersistenceErrorCode;

public class PersistenceManagerImpl implements IPersistenceManager {
	private Session session = null;

	public static final ThreadLocal<Session> thread = new ThreadLocal<Session>();

	@Override
	public Session openSessionAndBeginTransaction() throws PersistenceException {
		//logger.info("ENTERING..");
		try {
			session = thread.get();
			if (session == null) {
				session = HibernateUtil.getSessionFactory().openSession();

				thread.set(session);
			}
			session.beginTransaction();
			//logger.debug("OBTAINED A SESSION " + session);
		} catch (HibernateException e) {
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		//logger.info("EXITING..");

		return session;
	}

	@Override
	public void closeAndCommitSession() throws PersistenceException {
		// TODO Auto-generated method stub
		//logger.info("ENTRY....");
		try {
			if (session != null && session.isOpen()) {
				session = thread.get();
				session.flush();
				session.getTransaction().commit();

				//logger.info("SESSION COMMITTED");
			}
		} catch (HibernateException e) {
			//logger.fatal(e);
			e.printStackTrace();
			try {
				session.getTransaction().rollback();
			} catch (HibernateException e1) {
				throw new PersistenceException(
						IPersistenceErrorCode.DATABASE_PROBLEM);

			}
			//logger.info("THE TRANSACTION HAS BEEN ROLLED BACK");

			if (e instanceof ConstraintViolationException) {

				throw new PersistenceException(e,
						IPersistenceErrorCode.DATABASE_CONSTRAINT_ERROR);

			} else if (e instanceof StaleObjectStateException) {
				throw new PersistenceException(e,
						IPersistenceErrorCode.YOU_R_USING_STALE_DATA);

			} else {

				throw new PersistenceException(e,
						IPersistenceErrorCode.DATABASE_PROBLEM);
			}

		} finally {
			// close the session to return to the pool
			if (session != null && session.isOpen()) {
				session = thread.get();
				thread.set(null);

				session.close();
				//logger.info("SESSION CLOSED AS WELL.");
			}
		}
		//logger.info("EXIT.....");
		
	}

	public void closeSessionAndRollbackTransaction()
			throws PersistenceException {
		try {
			if (session != null && session.isOpen()) {
				session = thread.get();
				session.getTransaction().rollback();
				thread.set(null);

				session.close();
				//logger.info("SESSION CLOSED AND TRANSACTION ROLLED BACK.");
			}
		} catch (HibernateException e) {
			e.printStackTrace();
		}
	}
}
