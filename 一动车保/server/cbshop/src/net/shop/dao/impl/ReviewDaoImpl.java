/*
 * 
 * 
 * 
 */
package net.shop.dao.impl;

import java.util.List;

import javax.persistence.FlushModeType;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import net.shop.Filter;
import net.shop.Order;
import net.shop.Page;
import net.shop.Pageable;
import net.shop.dao.ReviewDao;
import net.shop.entity.Member;
import net.shop.entity.Product;
import net.shop.entity.Review;
import net.shop.entity.Review.Type;

import org.springframework.stereotype.Repository;

/**
 * Dao - 评论
 * 
 * 
 * 
 */
@Repository("reviewDaoImpl")
public class ReviewDaoImpl extends BaseDaoImpl<Review, Long> implements ReviewDao {

	@Override
	public List<Review> findList(Member member, Product product, Type type, Boolean isShow, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Review> criteriaQuery = criteriaBuilder.createQuery(Review.class);
		Root<Review> root = criteriaQuery.from(Review.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("member"), member));
		}
		if (product != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("product"), product));
		}
		if (type == Type.positive) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.ge(root.<Number> get("score"), 4));
		} else if (type == Type.moderate) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.<Number> get("score"), 3));
		} else if (type == Type.negative) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.le(root.<Number> get("score"), 2));
		}
		if (isShow != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isShow"), isShow));
		}
		criteriaQuery.where(restrictions);
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	@Override
	public Page<Review> findPage(Member member, Product product, Type type, Boolean isShow, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Review> criteriaQuery = criteriaBuilder.createQuery(Review.class);
		Root<Review> root = criteriaQuery.from(Review.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("member"), member));
		}
		if (product != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("product"), product));
		}
		if (type == Type.positive) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.ge(root.<Number> get("score"), 4));
		} else if (type == Type.moderate) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.<Number> get("score"), 3));
		} else if (type == Type.negative) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.le(root.<Number> get("score"), 2));
		}
		if (isShow != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isShow"), isShow));
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

	@Override
	public Long count(Member member, Product product, Type type, Boolean isShow) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Review> criteriaQuery = criteriaBuilder.createQuery(Review.class);
		Root<Review> root = criteriaQuery.from(Review.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("member"), member));
		}
		if (product != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("product"), product));
		}
		if (type == Type.positive) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.ge(root.<Number> get("score"), 4));
		} else if (type == Type.moderate) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.<Number> get("score"), 3));
		} else if (type == Type.negative) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.le(root.<Number> get("score"), 2));
		}
		if (isShow != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isShow"), isShow));
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}

	@Override
	public boolean isReviewed(Member member, Product product) {
		if (member == null || product == null) {
			return false;
		}
		String jqpl = "select count(*) from Review review where review.member = :member and review.product = :product";
		Long count = entityManager.createQuery(jqpl, Long.class).setFlushMode(FlushModeType.COMMIT).setParameter("member", member).setParameter("product", product).getSingleResult();
		return count > 0;
	}

	@Override
	public long calculateTotalScore(Product product) {
		if (product == null) {
			return 0L;
		}
		String jpql = "select sum(review.score) from Review review where review.product = :product and review.isShow = :isShow";
		Long totalScore = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT).setParameter("product", product).setParameter("isShow", true).getSingleResult();
		return totalScore != null ? totalScore : 0L;
	}

	@Override
	public long calculateScoreCount(Product product) {
		if (product == null) {
			return 0L;
		}
		String jpql = "select count(*) from Review review where review.product = :product and review.isShow = :isShow";
		return entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT).setParameter("product", product).setParameter("isShow", true).getSingleResult();
	}

}