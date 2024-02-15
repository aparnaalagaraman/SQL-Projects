/* Cleaning the data */
SELECT * 
	FROM [Portfolio Project].[dbo].[NashvilleHousing]

-------------------------------------------------------------------------
/* Standardize Date Format*/
SELECT SaleDate,CONVERT(DATE, SaleDate) AS SaleDateConverted
	FROM [Portfolio Project].[dbo].[NashvilleHousing]

/*Adding a new coulmn "SaleDateConverted" in database*/

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

/* Updating the  column "SaleDateConverted" with the converted date*/

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE, SaleDate);

----------------------------------------------------------------------------
/* Populate Property address data*/


SELECT ParcelID,
	   PropertyAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing]
WHERE PropertyAddress IS NULL

SELECT a.ParcelID,
	   a.PropertyAddress,
	   b.ParcelID,
	   b.PropertyAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing] a
INNER JOIN [Portfolio Project].[dbo].[NashvilleHousing] b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

/* Populating the NULL Property address with the corresponding Prpoerty address*/
SELECT a.ParcelID,
	   a.PropertyAddress,
	   b.ParcelID,
	   b.PropertyAddress,
	   ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].[dbo].[NashvilleHousing] a
INNER JOIN [Portfolio Project].[dbo].[NashvilleHousing] b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

/*Updating the null property address with the corresponding b.PropertyAddress with self-join*/
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].[dbo].[NashvilleHousing] a
INNER JOIN [Portfolio Project].[dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

----------------------------------------------------------------------------
/*Splitting the property Address into separate columns (Address,City,State)*/


SELECT PropertyAddress,
	   SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS address,
	   SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) AS city
	FROM [Portfolio Project].[dbo].[NashvilleHousing]

/* Altering the table NashvilleHousing to add new columns for address and city*/
/* Creating new column PropertySplitAddress*/

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

/* Creating new column PropertySplitCity*/
ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

/* Updating the data to PropertySplitAddress,PropertySplitCity*/

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress));

--------------------------------------------------------------------------------------------------------------
/*Populate Owner Address*/
SELECT OwnerAddress 
	FROM [Portfolio Project].[dbo].[NashvilleHousing]

/* Splitting the Owner address as 3 different columns address, city, state*/

SELECT OwnerAddress,
	   PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS owneraddress,
	   PARSENAME(REPLACE(OwnerAddress,',' , '.'), 2) AS ownercity,
	   PARSENAME(REPLACE(OwnerAddress,',' , '.'), 1) AS ownerstate
FROM [Portfolio Project].[dbo].[NashvilleHousing]

/* Altering the table NashvilleHousing to add new columns for owneraddress and ownercity*/
/* Creating new column OwnerSplitAddress*/

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

/* Creating new column OwnerSplitCity*/
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

/* Creating new column OwnerSplitState*/
ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

/* Updating the data to OwnerSplitAddress,OwnerSplitCity*/

UPDATE NashvilleHousing
SET OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',' , '.'), 2);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',' , '.'), 1);

SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]

--------------------------------------------------------------------------------------------------------------
/* Changing Y and N to Yes and No in the field "sold as vacant"*/
SELECT DISTINCT(SoldAsVacant),
	   COUNT(SoldAsVacant)
FROM [Portfolio Project].[dbo].[NashvilleHousing]
GROUP BY SoldAsVacant

/* Using case statement to change Y and N to Yes and No*/

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant ='Y' THEN 'Yes'
		 WHEN SoldAsVacant ='N' THEN 'No'
		 ELSE SoldAsVacant
	END
FROM [Portfolio Project].[dbo].[NashvilleHousing]

/* Updating the table [NashvilleHousing] with the above case*/

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant ='Y' THEN 'Yes'
		 WHEN SoldAsVacant ='N' THEN 'No'
		 ELSE SoldAsVacant
	END
--------------------------------------------------------------------------------------------------------------
/*Remove Duplicates */
WITH RowNumCTE AS(
SELECT *,
       ROW_NUMBER() OVER(
	   PARTITION BY ParcelID,
				    PropertyAddress,
					SaleDate,
					SalePrice,
					LegalReference
			        ORDER BY UniqueID
					) row_num
FROM [Portfolio Project].[dbo].[NashvilleHousing]
)

SELECT * 
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress

--------------------------------------------------------------------------------------------------------------
/* Delete Unused Columns */
ALTER TABLE [Portfolio Project].[dbo].[NashvilleHousing]
DROP COLUMN OwnerAddress,PropertyAddress,TaxDistrict



