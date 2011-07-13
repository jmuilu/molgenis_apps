package org.molgenis.matrix.ui.manager;

import matrix.AbstractDataMatrixInstance;

import org.molgenis.data.Data;
import org.molgenis.matrix.Matrix;
import org.molgenis.matrix.TargetFeatureMemoryMatrix;

public class BrowserModel {
	private int colStart; //calculated from previous colStart, action, stepsize, colMax, width
	private int colStop; //inferred from colStart, colMax and width
	private int rowStart; //calculated from previous rowStart, action, stepsize, rowMax, height
	private int rowStop; //inferred from rowStart, rowMax and height
	private int colMax; //based on number of cols in matrix instance
	private int rowMax; //based on number of rows in matrix instance
	private int width; //intented width; always user controlled.
	private int height; //intented height; always user controlled.
	private int stepSize; //intented stepsize; always user controlled.
	private Matrix instance; //passed on instantiation
	private Matrix subMatrix; //retrieved from instance using most other variables
	
	public int getColStart() {
		return colStart;
	}
	public void setColStart(int colStart) {
		this.colStart = colStart;
	}
	public int getColStop() {
		return colStop;
	}
	public void setColStop(int colStop) {
		this.colStop = colStop;
	}
	public int getRowStart() {
		return rowStart;
	}
	public void setRowStart(int rowStart) {
		this.rowStart = rowStart;
	}
	public int getRowStop() {
		return rowStop;
	}
	public void setRowStop(int rowStop) {
		this.rowStop = rowStop;
	}
	public int getColMax() {
		return colMax;
	}
	public void setColMax(int colMax) {
		this.colMax = colMax;
	}
	public int getRowMax() {
		return rowMax;
	}
	public void setRowMax(int rowMax) {
		this.rowMax = rowMax;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getStepSize() {
		return stepSize;
	}
	public void setStepSize(int stepSize) {
		this.stepSize = stepSize;
	}
	public Matrix getInstance() {
		return instance;
	}
	public void setInstance(Matrix instance) {
		this.instance = instance;
	}
	public Matrix getSubMatrix() {
		return subMatrix;
	}
	public void setSubMatrix(Matrix subMatrix) {
		this.subMatrix = subMatrix;
	}

}
